import logging
import os
import sys

from fastai.vision import load_learner
import structlog


# load the fastai model
LEARNER = load_learner('/recycling_classification/data', file=os.environ['MODEL_FILENAME'])

# Set up logging.
logging.basicConfig(format='%(message)s', stream=sys.stdout, level=logging.INFO)

structlog.configure(
    processors=[
        structlog.stdlib.filter_by_level,
        structlog.stdlib.add_logger_name,
        structlog.stdlib.add_log_level,
        structlog.stdlib.PositionalArgumentsFormatter(),
        structlog.processors.TimeStamper(fmt='iso'),
        structlog.processors.StackInfoRenderer(),
        structlog.processors.format_exc_info,
        structlog.processors.JSONRenderer(sort_keys=True),
    ],
    context_class=structlog.threadlocal.wrap_dict(dict),
    logger_factory=structlog.stdlib.LoggerFactory(),
    cache_logger_on_first_use=True,
)

logger = structlog.get_logger('recycling_classification')
