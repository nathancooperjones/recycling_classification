#!/bin/bash

aws s3 sync $S3_PATH $DATA_DIR --exclude "*" --include "$MODEL_FILENAME"
aws s3 sync $S3_PATH $DATA_DIR --exclude "*" --include "$CSR_FILENAME"
aws s3 sync $S3_PATH $DATA_DIR --exclude "*" --include "$UID_TO_USER_FILENAME"
aws s3 sync $S3_PATH $DATA_DIR --exclude "*" --include "$IID_TO_ITEM_FILENAME"
