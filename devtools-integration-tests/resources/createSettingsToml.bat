@echo off
certutil -decode token.txt token-decode.txt
set /p accesstoken=<token-decode.txt

mkdir "bal-integration-packaging-home"
echo [central]>"bal-integration-packaging-home\Settings.toml"
echo accesstoken="%accesstoken%">>"bal-integration-packaging-home\Settings.toml"
