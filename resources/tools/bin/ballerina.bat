@echo off

REM ---------------------------------------------------------------------------
REM  Copyright (c) 2019, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
REM
REM  WSO2 Inc. licenses this file to you under the Apache License,
REM  Version 2.0 (the "License"); you may not use this file except
REM  in compliance with the License.
REM  You may obtain a copy of the License at
REM
REM      http://www.apache.org/licenses/LICENSE-2.0
REM
REM  Unless required by applicable law or agreed to in writing,
REM  software distributed under the License is distributed on an
REM  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
REM  KIND, either express or implied. See the License for the
REM  specific language governing permissions and limitations
REM  under the License.
REM ---------------------------------------------------------------------------

set BALLERINA_HOME=
set FILE_PATH=%~sdp0..\distributions\ballerina-version

if ("%1"=="dist")

set dist=false
if "$1" == "dist" set dist=true
if "$2" == "dist" set dist=true
if "%dist%" == "true" (
   java -jar %~sdp0..\dependencies\ballerina-update-tool-${ballerina.update.tool.version}.jar %*
) else (

    if exist ~\.ballerina\ballerina-version (
       set "FILE_PATH=~\.ballerina\ballerina-version"
    )

    for /f %%a in (%FILE_PATH%) do (
      set "BALLERINA_HOME=%%a"
    )

    %~sdp0..\distributions\%BALLERINA_HOME%\bin\ballerina.bat %*
)

set help=false
if "$1" == "" set help=true

if "$1" == "help" (
    if "$2" == "" (
        set help=true
    )
)

if "%dist%" == "true" (
    java -jar %~sdp0..\dependencies\ballerina-update-tool-${ballerina.update.tool.version}.jar %*
)