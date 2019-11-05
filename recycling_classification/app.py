from io import BytesIO
import time
import uuid

from fastai.vision import image as im
from flasgger import Swagger
from flask import abort, Flask, g, jsonify, request
import requests

from recycling_classification.config_app import LEARNER, logger


app = Flask(__name__)

# Setup swagger for API documentation
swagger = Swagger(app)


@app.before_request
def initiate_log():
    g.start_time = time.time()
    g.log = logger.new(
        request_id=str(uuid.uuid4()),
        path=request.path,
        host=request.host,
        method=request.method,
        user_agent=request.environ['HTTP_USER_AGENT'],
    )


@app.after_request
def log_request(response):
    g.log.info(
        'Post Request Log',
        status=response.status_code,
        duration=round(time.time() - g.start_time, 5),
        ip=request.headers.get('X-Forwarded-For', request.remote_addr)
    )
    return response


@app.route('/predict_recylable_from_image_url', methods=['GET'])
def predict_recylable_from_image_url():
    """
    Get recycling item class prediction and probability from a `fastai` model.
    This endpoint accepts an image `url` as a query argument. It returns the recycling image
    `url`, `class`, and `probability` (probability of being that class) based on the image.
    To access the API Docs, visit host:port/apidocs (e.g.: 0.0.0.0:8000/apidocs)
    ---
    tags:
      - Probability of recycling class from image URL
    parameters:
      - name: url
        in: query
        type: string
        required: true
        description: url for recyling image to analyze
    responses:
      400:
        description: Bad Request
      200:
        description: OK
        properties:
          url:
            type: string
            example: google.com/images/plastic_bottle.jpg
          class:
            type: string
            example: plastics
          probability:
            type: float
            example: 0.992

    """
    url = _get_image_url_from_request(request)
    g.log = g.log.bind(url=url)

    try:
        response = requests.get(url)
        image_from_interwebs = im.open_image(BytesIO(response.content))
        g.log = g.log.bind(image_opened=True)

        pred_class, _, pred_probs = LEARNER.predict(image_from_interwebs)
        g.log = g.log.bind(prediction_made=True)

        output = {
            'url': url,
            'class': pred_class.obj,
            'probability': max(pred_probs.tolist()),
        }
        return jsonify(output)
    except Exception as e:
        print(e)
        abort(400, 'Issue in `predict_recylable_from_image_url` endpoint. Check API docs for usage.')


@app.route('/health', methods=['GET'])
def health_check():
    """
    Health Check.
    ---
    tags:
      - Health Check endpoint
    responses:
      200:
        description: OK
        properties:
          OK:
            type: integer
            example: 1
    """
    return jsonify({'OK': 1})


@app.route('/', methods=['GET'])
def hello_world():
    """A very friendly hello, world!"""
    return 'Hello, world!'


def _get_image_url_from_request(request):
    """Get url from request query string."""
    try:
        url = request.args.get('url')
        assert isinstance(url, str)
    except Exception:
        abort(400, f'Invalid `url` value provided: {url}. '
                   'Must pass `url` properly in request query string. '
                   'Please review API docs.')
    return url


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=80)
