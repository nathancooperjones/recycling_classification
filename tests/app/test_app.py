import requests

URL = 'http://0.0.0.0:80'


def test_health():
    res = requests.get(URL + '/health')
    assert res.status_code == 200


def test_predict_recylable_from_image_url():
    payload = {'url': 'http://misteroclass.files.wordpress.com/2011/03/aluminumcan.jpg'}
    res = requests.post(URL + '/predict_recylable_from_image_url', params=payload)
    assert res.status_code == 200


def test_predict_recylable_from_image_url_no_url():
    res = requests.post(URL + '/predict_recylable_from_image_url')
    assert res.status_code == 400
    assert 'Invalid `url` value provided' in res.text


def test_predict_recylable_from_image_url_blank_url():
    payload = {'url': ''}
    res = requests.post(URL + '/predict_recylable_from_image_url', params=payload)
    assert res.status_code == 400
    assert 'Unable to open image specified in `url`' in res.text
