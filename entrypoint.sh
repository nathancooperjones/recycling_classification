#!/bin/bash

sh /seeker/download_data.sh

cd /seeker/seeker/

gunicorn app:app \
    -b 0.0.0.0:8000 \
    --log-file - \
    --error-logfile - \
    --access-logfile - \
    --access-logformat "%(h)s %(t)s %(m)s %(U)s %(s)s %(L)s" \
    --workers 1 \
    --threads 6 \
    --timeout 3600
