import hashlib
import os

from fastai.vision import get_image_files, verify_images


def validate_images(image_path, ext='jpg'):
    """
    Validate images to ensure they can all open and do not have duplicates in the image directory.

    Parameters
    -------------
    image_path: string
        path to images to validate
    ext: string
        photo extension for `fastai`'s `verify_images` to use (default 'jpg')

    Side Effects
    -------------
    This function permanantely deletes invalid images that it cannot open, are not
    able to be converted to 'jpg's, or are duplicates of another image in the `image_path`.

    """
    # start with fastai `verify_images` to ensure we can open each image
    print('Verifying images...')
    verify_images(path=image_path,
                  delete=True,
                  ext=ext)

    # check for duplicate images by hashing
    # modified from: https://medium.com/@urvisoni/removing-duplicate-images-through-python-23c5fdc7479e
    print('Checking for duplicate images by hashing...')
    duplicates = list()
    hash_keys = dict()
    file_names = get_image_files(image_path)
    for index, filename in enumerate(file_names):
        if os.path.isfile(filename):
            with open(filename, 'rb') as f:
                filehash = hashlib.md5(f.read()).hexdigest()
            if filehash not in hash_keys:
                hash_keys[filehash] = index
            else:
                duplicates.append((index, hash_keys[filehash]))

    print(f'Deleting {len(duplicates)} duplicate images.')
    for index in duplicates:
        os.remove(file_names[index[0]])

    file_names = get_image_files(image_path)
    print(f'Image directory now contains {len(file_names)} valid images.')
