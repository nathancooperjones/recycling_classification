import os
from tempfile import NamedTemporaryFile

import boto3
from fastai.vision import load_learner


def file_to_s3(filename, s3_path=None):
    """
    Upload file to S3.

    Parameters
    -------------
    filename: string
        location of file to upload
    s3_path: string
        S3 path to bucket to upload file to. If `None`, file will be uploaded to
        $S3_PATH + `filename` (default None)

    Side Effects
    -------------
    Uploads file to S3, overwriting a file with the exact name if it exists.

    """
    if s3_path is None:
        s3_path = os.getenv('S3_PATH')
        if s3_path is None:
            error_message = ('Environment variable $S3_PATH not found. '
                             'Set this variable or pass in the `s3_path` argument.')
            raise ValueError(error_message)
        s3_path = os.path.join(s3_path, filename)
    bucket, key = get_bucket_and_key(s3_path)

    s3_client = boto3.client('s3')
    s3_client.upload_file(filename, bucket, key)

    print('Saved file to: {}'.format(s3_path))


def file_from_s3(s3_path, filename=None):
    """
    Load model from S3.

    Parameters
    -------------
    s3_path: string
        S3 path to bucket to download file from
    filename: string
        location to save file to on local machine. If `None`, defaults to $DATA_DIR (default None)

    Side Effects
    -------------
    Downloads file to local machine, overwriting a file with the exact name if it exists.

    """
    if filename is None:
        filename = os.environ['DATA_DIR']

    bucket, key = get_bucket_and_key(s3_path)

    s3_client = boto3.client('s3')
    s3_client.download_file(bucket, key, filename)

    print('Downloaded file to: {}'.format(filename))


def model_to_s3(learner, s3_path):
    """
    Upload model to S3 as pickled file.

    Parameters
    -------------
    learner: fastai.Learner
        trained fastai model to save
    s3_path: string
        S3 path to bucket for upload
        Ex: s3://recycling-classification/folder/filename.pkl

    Side Effects
    -------------
    Uploads file to S3, overwriting a file with the exact name if it exists.

    """
    bucket, key = get_bucket_and_key(s3_path)

    s3_client = boto3.client('s3')

    temp_file = NamedTemporaryFile()
    learner.export(temp_file)
    s3_client.upload_file(temp_file.name, bucket, key)
    temp_file.close()

    print('Saved model to: {}'.format(s3_path))


def model_from_s3(s3_path):
    """
    Load model from S3 as `fastai.Learner`.

    Parameters
    -------------
    s3_path: string
        S3 path to bucket to download from
        Ex: s3://recycling-classification/folder/filename.pkl

    """
    bucket, key = get_bucket_and_key(s3_path)

    s3_client = boto3.client('s3')

    temp_file = NamedTemporaryFile()
    s3_client.download_file(bucket, key, temp_file.name)
    temp_file_pathname = temp_file.name[:temp_file.name.rindex('/')]
    temp_file_filename = temp_file.name[temp_file.name.rindex('/')+1:]
    learner = load_learner(temp_file_pathname, file=temp_file_filename)
    temp_file.close()

    return learner


def get_bucket_and_key(s3_path):
    """
    Get bucket and key from S3 path.

    Parameters
    -------------
    s3_path: string
        S3 path to bucket
        Ex: s3://recycling-classification/folder/file.pkl
        Ex: /recycling-classification/folder/file.pkl
        Ex: recycling-classification/folder/file.pkl

    Returns
    -------------
    bucket: string
        recycling-classification
    key: string
        folder/file.pkl

    """
    split_path = s3_path.replace('s3://', '').lstrip('/').split('/')
    bucket = split_path.pop(0)
    key = '/'.join(split_path)
    return bucket, key
