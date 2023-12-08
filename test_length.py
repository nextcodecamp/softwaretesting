import pytest
def get_length(string):
    return len(string)

def test_get_len():
    assert get_length('123') == 3   #test case for valid test
    assert get_length('123') == 2   #test case for invalid test
        