from recycling_classification.s3_helper import get_bucket_and_key


EXPECTED_BUCKET = 'recycling-classification'
EXPECTED_KEY = 'folder/file.pkl'


def test_get_bucket_and_key_full_url():
    actual_bucket, actual_key = get_bucket_and_key(s3_path='s3://recycling-classification/folder/file.pkl')

    assert actual_bucket == EXPECTED_BUCKET
    assert actual_key == EXPECTED_KEY


def test_get_bucket_and_key_no_s3():
    actual_bucket, actual_key = get_bucket_and_key(s3_path='/recycling-classification/folder/file.pkl')

    assert actual_bucket == EXPECTED_BUCKET
    assert actual_key == EXPECTED_KEY


def test_get_bucket_and_key_relative():
    actual_bucket, actual_key = get_bucket_and_key(s3_path='recycling-classification/folder/file.pkl')

    assert actual_bucket == EXPECTED_BUCKET
    assert actual_key == EXPECTED_KEY
