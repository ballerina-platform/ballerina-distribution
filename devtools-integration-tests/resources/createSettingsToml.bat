mkdir "bal-integration-packaging-home"
@echo off
echo [central]>"bal-integration-packaging-home\Settings.toml"
echo accesstoken="YWYwMjkyODgtNjhkZC0zOTVmLTk5MzQtYTgyYWRjM2NlYzZi">>"bal-integration-packaging-home\Settings.toml"

SET BALLERINA_HOME_DIR="bal-integration-packaging-home"
SET BALLERINA_STAGE_CENTRAL="true"
