#!/bin/bash

aws s3 sync $S3_PATH $DATA_DIR --exclude "*" --include "$MODEL_FILENAME"
