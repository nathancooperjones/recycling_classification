import pytest


@pytest.mark.usefixtures('example_fixture')
def test_example(example_fixture):
    actual = example_fixture
    expected = 'a simple test'

    assert actual == expected
