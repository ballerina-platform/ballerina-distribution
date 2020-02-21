// Copyright (c) 2020 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/http;
import ballerina/stringutils;
import ballerina/log;
import ballerina/kubernetes;
import ballerina/istio;

@kubernetes:Service {}
@istio:Gateway {}
@istio:VirtualService {}
listener http:Listener travelAgencyEP = new(9090);

http:Client airlineReservationEP = new("http://airline-reservation:8080/airline");
http:Client hotelReservationEP = new("http://hotel-reservation:7070/hotel");
http:Client carRentalEP = new("http://car-rental:6060/car");

// Travel agency service to arrange a complete tour for a user
@kubernetes:Deployment {
    buildImage: false
}
@http:ServiceConfig {
    basePath: "/travel"
}
service travelAgencyService on travelAgencyEP {
    // Resource to arrange a tour
    @http:ResourceConfig {
        methods: ["POST"],
        consumes: ["application/json"],
        produces: ["application/json"],
        path: "/arrange"
    }
    resource function arrangeTour(http:Caller caller, http:Request inRequest) returns error? {
        http:Response outResponse = new;
        json inReqPayload = {};

        // Try parsing the JSON payload from the user request
        var payload = inRequest.getJsonPayload();
        if (payload is json) {
            // Valid JSON payload
            inReqPayload = payload;
        } else {
            // NOT a valid JSON payload
            outResponse.statusCode = 400;
            outResponse.setJsonPayload({
                Message: "Invalid payload - Not a valid JSON payload"
            });
            var result = caller->respond(outResponse);
            handleError(result);
            return;
        }

        json|error inReqPayloadNameJson = inReqPayload.Name;
        json|error inReqPayloadArrivalDateJson = inReqPayload.ArrivalDate;
        json|error inReqPayloadDepartureDateJson = inReqPayload.DepartureDate;
        json|error airlinePreference = inReqPayload.Preference.Airline;
        json|error hotelPreference = inReqPayload.Preference.Accommodation;
        json|error carPreference = inReqPayload.Preference.Car;

        // If payload parsing fails, send a "Bad Request" message as the response
        if (inReqPayloadNameJson is error || inReqPayloadArrivalDateJson is error ||
            inReqPayloadDepartureDateJson is error || airlinePreference is error || hotelPreference is error ||
            carPreference is error) {
            outResponse.statusCode = 400;
            outResponse.setJsonPayload({
                Message: "Bad Request - Invalid Payload"
            });
            var result = caller->respond(outResponse);
            handleError(result);
            return;
        }

        // Reserve airline ticket for the user by calling Airline reservation service
        // construct the payload
        json outReqPayloadAirline = {
            Name: checkpanic inReqPayloadNameJson,
            ArrivalDate: checkpanic inReqPayloadArrivalDateJson,
            DepartureDate: checkpanic inReqPayloadDepartureDateJson,
            Preference: checkpanic airlinePreference
        };

        // Send a post request to airlineReservationService with appropriate payload and get response
        http:Response|error inResAirline = airlineReservationEP->post("/reserve", <@untainted> outReqPayloadAirline);
        if (inResAirline is error) {
            outResponse.setJsonPayload({
                Message: "Failed to reserve airline! Unable to connect to airline service."
            });
            var result = caller->respond(outResponse);
            handleError(result);
            return;
        }

        http:Response inResponseAirline = <http:Response>inResAirline;
        // Get the reservation status
        json|error airlineResPayload = inResponseAirline.getJsonPayload();
        if (airlineResPayload is error) {
            outResponse.setJsonPayload({
                Message: "Failed to reserve airline! Unable to get payload from response."
            });
            var result = caller->respond(outResponse);
            handleError(result);
            return;
        }

        json airlineJsonPayload = <json>airlineResPayload;
        string airlineStatus = airlineJsonPayload.Status.toString();
        // If reservation status is negative, send a failure response to user
        if (stringutils:equalsIgnoreCase(airlineStatus, "Failed")) {
            outResponse.setJsonPayload({
                Message: "Failed to reserve airline! Provide a valid 'Preference' for 'Airline' and try again"
            });
            var result = caller->respond(outResponse);
            handleError(result);
            return;
        }

        // Reserve hotel room for the user by calling Hotel reservation service
        // construct the payload
        json outReqPayloadHotel = {
            Name: checkpanic inReqPayloadNameJson,
            ArrivalDate: checkpanic inReqPayloadArrivalDateJson,
            DepartureDate: checkpanic inReqPayloadDepartureDateJson,
            Preference: checkpanic hotelPreference
        };

        // Send a post request to hotelReservationService with appropriate payload and get response
        http:Response|error inResHotel = hotelReservationEP->post("/reserve", <@untainted> outReqPayloadHotel);
        if (inResHotel is error) {
            outResponse.setJsonPayload({
                Message: "Failed to reserve hotel! Unable to connect to hotel service."
            });
            var result = caller->respond(outResponse);
            handleError(result);
            return;
        }

        http:Response inResponseHotel = <http:Response>inResHotel;
        // Get the reservation status
        json|error hotelResPayload = inResponseHotel.getJsonPayload();
        if (hotelResPayload is error) {
            outResponse.setJsonPayload({
                Message: "Failed to reserve hotel! Unable to get payload from response."
            });
            var result = caller->respond(outResponse);
            handleError(result);
            return;
        }

        json hotelJsonPayload = <json>hotelResPayload;
        string hotelStatus = hotelJsonPayload.Status.toString();
        // If reservation status is negative, send a failure response to user
        if (stringutils:equalsIgnoreCase(hotelStatus, "Failed")) {
            outResponse.setJsonPayload({
                Message: "Failed to reserve hotel! Provide a valid 'Preference' for 'Accommodation' and try again"
            });
            var result = caller->respond(outResponse);
            handleError(result);
            return;
        }

        // Renting car for the user by calling Car rental service
        // construct the payload
        json outReqPayloadCar = {
            Name: checkpanic inReqPayloadNameJson,
            ArrivalDate: checkpanic inReqPayloadArrivalDateJson,
            DepartureDate: checkpanic inReqPayloadDepartureDateJson,
            Preference: checkpanic carPreference
        };

        // Send a post request to carRentalService with appropriate payload and get response
        http:Response|error inResCar = carRentalEP->post("/rent", <@untainted> outReqPayloadCar);
        if (inResCar is error) {
            outResponse.setJsonPayload({
                Message: "Failed to rent car! Unable to connect to car service."
            });
            var result = caller->respond(outResponse);
            handleError(result);
            return;
        }

        http:Response inResponseCar = <http:Response>inResCar;
        // Get the rental status
        json|error carResPayload = inResponseCar.getJsonPayload();
        if (carResPayload is error) {
            outResponse.setJsonPayload({
                Message: "Failed to rent car! Unable to get payload from response."
            });
            var result = caller->respond(outResponse);
            handleError(result);
            return;
        }

        json carJsonPayload = <json>carResPayload;
        string carRentalStatus = carJsonPayload.Status.toString();
        // If rental status is negative, send a failure response to user
        if (stringutils:equalsIgnoreCase(carRentalStatus, "Failed")) {
            outResponse.setJsonPayload({
                "Message": "Failed to rent car! Provide a valid 'Preference' for 'Car' and try again"
            });
            var result = caller->respond(outResponse);
            handleError(result);
            return;
        }

        // If all three services response positive status, send a successful message to the user
        outResponse.setJsonPayload({
            Message: "Congratulations! Your journey is ready!!"
        });
        var result = caller->respond(outResponse);
        handleError(result);
        return ();
    }
}

function handleError(error? result) {
    if (result is error) {
        log:printError(result.reason(), result);
    }
}
