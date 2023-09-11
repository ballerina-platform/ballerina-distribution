// Copyright (c) 2023 WSO2 LLC. (http://www.wso2.org). All Rights Reserved.
//
// WSO2 LLC. licenses this file to you under the Apache License,
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

import ballerina/graphql;

# Episodes of Starwars Series
public enum Episode {
    # The episode new hope.
    #       `Luke Skywalker` joins forces with a Jedi Knight.
    #
    # Check new lines in the documentation
    #
    NEWHOPE,
    #
    EMPIRE,
    # The episode jedi
    JEDI
}

#
# + stars - Number of stars
# + episode - The episode
public type Review record {
    int stars;
    Episode episode?;
    string commentary?;
};

# The review input type
public type ReviewInput record {
    # Number of stars
    int stars;
    string commentary;
};

public type Profile distinct service object {
    # The name of the human
    # + id -
    # + age -
    # This should be an integer
    #
    # This is a Non-Null type argument
    # + return - The name
    resource function get name(string id, int age, boolean isAdult) returns string;
};

# Planet of the Human
public type Planet distinct service object {
    # The home planet of the human, or null if unknown
    # + return - The homePlanet
    resource function get homePlanet() returns string?;
};

# A mechanical character from the Star Wars universe.
# It can be a **Human** or a ~Droid~
public type Character distinct service object {
    *Profile;

    # The unique identifier of the character
    # + return - The id
    resource function get id() returns string;

    # The episodes this character appears in
    # + return - The episodes
    # # Deprecated
    # This field is deprecated.
    # Use `appears` field instead of this.
    @deprecated
    resource function get appearsIn() returns Episode[];
};

# A humanoid creature from the Star Wars universe
distinct service class Human {
    *Character;
    *Planet;
    # The unique identifier of the human
    #   The type of the id is String
    #
    # The "id" returns a string
    # + return - The id
    resource function get id() returns string {
        return "";
    }

    # The name of the human
    # + return - The name
    resource function get name(string id, int age, boolean isAdult) returns string {
        return "";
    }

    # The home planet of the human, or null if unknown
    # + return - The homePlanet
    resource function get homePlanet() returns string? {
        return;
    }

    # Height in meters, or null if unknown
    # + return - The height
    resource function get height() returns float? {
        return ;
    }

    # Mass in kilograms, or null if unknown
    # + return - The mass
    resource function get mass() returns int? {
        return ;
    }

    # The episodes this human appears in
    # + return - The episodes
    resource function get appearsIn() returns Episode[] {
        return [JEDI];
    }
}

service /graphql on new graphql:Listener(9000) {

    # Fetch the hero of the Star Wars
    # + episode - The episode which hero appears
    # This is a Nullable input
    #
    # + return - The hero
    resource function get hero(Episode? episode) returns Profile {
        return new Human();
    }

    # Returns reviews of the Star Wars
    # + episode - The episode
    # Default value of the `episode` is ""JEDI""
    # + return - The reviews
    resource function get reviews(Episode episode = JEDI, string name = "Luke") returns Review?[] {
        return [];
    }

    # Returns characters by id, or null if character is not found
    # + name - Name of the character
    #
    # + return - The characters
    resource function get characters(string[] idList, string name) returns Character?[] {
        Character[] characters = [new Human()];
        return characters;
    }

    # Returns a human by id,
    # or null if human is not found
    # + id - **id** of the human
    # + return - The Human
    resource function get human(string id) returns Human? {
        if id.includes("human") {
            return new Human();
        }
        return;
    }

    # The home planet of the human, or null if unknown
    # + return - The homePlanet
    resource function get planet() returns Planet? {
        return;
    }

    # Add new reviews.
    # Return the updated review values
    # + episode - Episode name
    # + reviewInput - Review of the episode.
    #
    # This should be an `input object` type value
    # + return - The reviews
    remote function createReview(Episode episode, ReviewInput reviewInput) returns Review {
        Review review = {
            stars: reviewInput.stars
        };
        return review;
    }
}
