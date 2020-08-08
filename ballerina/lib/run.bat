@echo off

REM Change directory to provided path
cd %1

REM  run ballerina file as background process
START "" /b %2 run --experimental %3

REM wait till server starts
ping -n 10 127.0.0.0 > nul

REM invoke curl commnads
cmd<%4

REM kill the process which is using the server ports
for /f "tokens=*" %%b in (%5) do (
IF "%%b."=="." (echo "empty") ELSE (

netstat /o /a | find /i "listening" | find ":%%b" > nul 2>nul && (
for /f "tokens=5" %%a in ('netstat -aon ^| find ":%%b" ^| find "LISTENING"') do taskkill /f /pid %%a
) || (
 echo %%b is not open
)
)
)
