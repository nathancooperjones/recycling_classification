# Deep Learning Recycling Classification

![](https://www.laredosolidwaste.com/images/icons/FAQicon.jpg)

Have you ever held a piece of trash and been paralyzed with the fear of the unknown: is it trash or recycling? If it's trash that ends up in recycling, the whole bin could be contaminated, killing the planet! If it's recyclables ending up in the trash, you missed a potential opportunity to save the planet, thereby killing the planet! It is _this_ endless confusion that brought the idea for a recycling detection algorithm, one that inputs a picture and tells you not only if something is recyclable, but how to properly recycle it.

Using `fastai`'s deep learning library, this is a small project made to do just this: input images to determine types of recyclables and providing proper recycling instructions for each through a simple API.

![](https://user-images.githubusercontent.com/31417712/67293106-951f0800-f4a9-11e9-9c63-a974a5ea1853.png)

### App Functionality Checklist
- [X] Curate initial dataset
- [X] Create preliminary deep learning model with this initial dataset
- [ ] Set up Flask app to accept images and return predicted recyclable class
- [ ] Advance image dataset to include more real-world examples, more categories, etc.
- [ ] Create more advanced deep learning model with this newer dataset
- [ ] Use object detection model to determine recyclable class for many objects in an image
- [ ] Deploy this for public use

### Development
Begin by installing [Docker](https://docs.docker.com/install/) if you have not already. Once Docker is running, run development from within the Docker container:

```bash
# export path to data directory to mount in Docker container
export RECYCLE_DATA_PATH=$HOME/data/recycling_classification

# build the Docker image
docker build -t recycling_classification .

# run the Docker container in interactive mode.
docker run \
    -it \
    --rm \
    -v "${RECYCLE_DATA_PATH}:/data" \
    -v "${PWD}:/recycling_classification" \
    -p 8888:8888 \
    -p 8000:8000 \
    -e AWS_ACCESS_KEY_ID="$(aws --profile default configure get aws_access_key_id)" \
    -e AWS_SECRET_ACCESS_KEY="$(aws --profile default configure get aws_secret_access_key)" \
    recycling_classification /bin/bash -c "pip install -r requirements-dev.txt && bash"
```

Before starting the app, download the desired model and mapping dictionary with:
```bash
bash download_data.sh
```

From within the container, either of the following two commands will start the app:
```bash
# Debug mode with flask native serving
python3 recycling_classification/app.py

# Production mode with gunicorn serving
bash run_app.sh
```

In either setup, we can still make requests to the service with
```bash
curl -X GET http://0.0.0.0:8000/health
```

### Start Jupyter Lab
To run jupyterlab, start the container and execute the following:
```bash
jupyter lab --ip 0.0.0.0 --no-browser --allow-root --NotebookApp.token='' --NotebookApp.password=''
```
Connect to Jupyter here: [http://localhost:8888/tree?](http://localhost:8888/tree?)
