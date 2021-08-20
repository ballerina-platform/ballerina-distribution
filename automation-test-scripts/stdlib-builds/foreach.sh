#!/bin/bash
set -e

# Command to create PRs:
# gh pr create --title "Add extracted bala in the zip artifact" --body "$(cat /home/user/Desktop/pr_template.txt)" --base master --head azinneera:repo-restructure

################### How to run the script #######################
# 1) Build lang repo and publish to maven local: ./gradlew clean build -x check publishToMavenLocal
# 2) Run this script with the following command. Replace `beta.3-SNAPSHOT` with the appropriate version
: '
sh foreach.sh "./gradlew clean build -PballerinaLangVersion=2.0.0-beta.3-SNAPSHOT \
-PstdlibTimeVersion=2.0.0-beta.3-SNAPSHOT \
-PstdlibIoVersion=0.6.0-beta.3-SNAPSHOT \
-PstdlibRegexVersion=0.7.0-beta.3-SNAPSHOT \
-PstdlibTaskVersion=2.0.0-beta.3-SNAPSHOT \
-PstdlibLogVersion=1.1.0-beta.3-SNAPSHOT \
-PstdlibOsVersion=0.8.0-beta.3-SNAPSHOT \
-PstdlibCryptoVersion=1.1.0-beta.3-SNAPSHOT \
-PstdlibCacheVersion=2.1.0-beta.3-SNAPSHOT \
-PstdlibMimeVersion=1.1.0-beta.3-SNAPSHOT \
-PstdlibFileVersion=0.7.0-beta.3-SNAPSHOT \
-PstdlibAuthVersion=1.1.0-beta.3-SNAPSHOT \
-PstdlibJwtVersion=1.1.0-beta.3-SNAPSHOT \
-PstdlibOAuth2Version=1.1.0-beta.3-SNAPSHOT \
-PstdlibUuidVersion=0.10.0-beta.3-SNAPSHOT \
-PstdlibUrlVersion=1.1.0-beta.3-SNAPSHOT \
-PstdlibHttpVersion=1.1.0-beta.3-SNAPSHOT \
-PstdlibRandomVersion=0.10.0-beta.3-SNAPSHOT \
-PstdlibTransactionVersion=1.0.15-SNAPSHOT \
-PstdlibSqlVersion=0.6.0-beta.3-SNAPSHOT \
publishToMavenLocal"
'

# level 1
(cd module-ballerina-io ; eval $1)
(cd module-ballerina-jballerina.java.arrays ; eval $1)
(cd module-ballerina-random ; eval $1)
(cd module-ballerina-regex ; eval $1)
(cd module-ballerina-time ; eval $1)
(cd module-ballerina-url ; eval $1)
(cd module-ballerina-xmldata ; eval $1)
# level 2
(cd module-ballerina-crypto ; eval $1)
(cd module-ballerina-log ; eval $1)
(cd module-ballerina-os ; eval $1)
(cd module-ballerina-task ; eval $1)
(cd module-ballerina-xslt ; eval $1)
# level 3
(cd module-ballerina-cache ; eval $1)
(cd module-ballerina-file ; eval $1)
(cd module-ballerina-ftp ; eval $1)
(cd module-ballerina-mime ; eval $1)
(cd module-ballerinax-nats ; eval $1)
(cd module-ballerinax-stan ; eval $1)
(cd module-ballerina-tcp ; eval $1)
(cd module-ballerina-udp ; eval $1)
(cd module-ballerina-uuid ; eval $1)
# level 4
(cd module-ballerina-auth ; eval $1)
(cd module-ballerina-email ; eval $1)
(cd module-ballerina-jwt ; eval $1)
(cd module-ballerina-oauth2 ; eval $1)
# level 5
(cd module-ballerina-http ; eval $1)
# level 6
(cd module-ballerina-graphql ; eval $1)
(cd module-ballerina-grpc ; eval $1)
(cd module-ballerinai-transaction ; eval $1)
(cd module-ballerina-websocket ; eval $1)
(cd module-ballerina-websub ; eval $1)
(cd module-ballerina-websubhub ; eval $1)
# level 7
(cd module-ballerinax-kafka ; eval $1)
(cd module-ballerinax-rabbitmq ; eval $1)
(cd module-ballerina-sql ; eval $1)
# level 8
(cd module-ballerinax-java.jdbc ; eval $1)
(cd module-ballerinax-mssql ; eval $1)
(cd module-ballerinax-mysql ; eval $1)
(cd module-ballerinax-postgresql ; eval $1)
