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

set BALLERINA_HOME=jballerina-1.0.0
set FILE_PATH=..\distributions\ballerina-version

if exist ~\.ballerina\ballerina-version (
   FILE_PATH=~\.ballerina\ballerina-version
)

for /f %%a in (%FILE_PATH%) do (
  BALLERINA_HOME=%%a
  exit /b
)

..\distributions\%BALLERINA_HOME%\bin\ballerina.bat %*
