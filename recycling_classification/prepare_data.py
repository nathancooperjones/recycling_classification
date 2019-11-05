import os

import hashlib
from fastai.vision import get_image_files, verify_images


def validate_images(image_path, ext='jpg'):
    """
    Validate images to ensure they can all open and are not exact duplicates of one another.

    Parameters
    -------------
    image_path: string
        path to images to validate
    ext: string
        photo extension for `fastai`'s `verify_images` to use (default 'jpg')

    Side Effects
    -------------
    This function permanantely deletes invalid images that it cannot open, are not
    able to be converted to 'jpg's, or are duplicates of another image.

    """
    # start with fastai `verify_images` to ensure we can open each image
    print('Verifying images...')
    verify_images(path=image_path,
                  delete=True,
                  ext=ext)

    # check for duplicate images by hashing
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
