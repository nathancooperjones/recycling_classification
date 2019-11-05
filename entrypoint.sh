#!/bin/bash

sh /recycling_classification/download_data.sh

cd /recycling_classification/recycling_classification/

gunicorn app:app \
    -b 0.0.0.0:80 \
    --log-file - \
    --error-logfile - \
    --access-logfile - \
    --access-logformat "%(h)s %(t)s %(m)s %(U)s %(s)s %(L)s" \
    --workers 1 \
    --threads 6 \
    --timeout 3600
