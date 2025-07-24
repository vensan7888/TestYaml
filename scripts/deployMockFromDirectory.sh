#!/bin/sh

# $1: Smart-mock server url, ex: 'http://localhost:8080'
# Full Command:
# 
#   To Clone Repo & Scan all Yaml files to deploy contracts to mock server
#     ex: sh scripts/deployMockFromDirectory.sh http://localhost:8080

MOCK_SERVER=$1

CURRENT_DIRECTORY=$(pwd)
dir=$(dirname "$0")"/"
SCRIPT_PATH=$dir
COMMON_PATH="$CURRENT_DIRECTORY/$SCRIPT_PATH/common"
echo "Path : $0 $dir"
# 2. Scan Directory
YAML_FILE_PATHS=$(sh "$COMMON_PATH"/find_yaml_files_in_directory.sh $CURRENT_DIRECTORY)

finalStatus="["
for file in "${YAML_FILE_PATHS[@]}"; do
    filePath=$FOLDER_PATH/$file
    echo $filePath
    # Return status of all endpoints in a given yaml file.
    status=$(sh "$COMMON_PATH"/yamlParser.sh $filePath $MOCK_SERVER)
    finalStatus="$finalStatus $status,"
done
finalStatus="$finalStatus]"
echo $finalStatus