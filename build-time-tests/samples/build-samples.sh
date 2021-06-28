#!/bin/bash
# ---------------------------------------------------------------------------
#  Copyright (c) 2021, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#  http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
# ----------------------------------------------------------------------------

BAL_DIST_PATH=$1
BAL_EXEC_PATH=$BAL_DIST_PATH/bin/bal
ARTEFACT_DIR=../build-time-data

SAMPLES_LIST=$(ls -d */)
mkdir -p "$ARTEFACT_DIR/offline"
mkdir -p "$ARTEFACT_DIR/online"

for sample in $SAMPLES_LIST
do
   sample_name=$(basename $sample)
   echo "Building sample '$sample'"
   $BAL_EXEC_PATH build --dump-build-time $sample
   cp "$sample/target/build-time.json" "$ARTEFACT_DIR/online/$sample_name-build-time.json"
done

for sample in $SAMPLES_LIST
do
   sample_name=$(basename $sample)
   echo "Building sample '$sample' offline"
   $BAL_EXEC_PATH build --dump-build-time --offline $sample
   cp "$sample/target/build-time.json" "$ARTEFACT_DIR/offline/$sample_name-build-time.json"
done
