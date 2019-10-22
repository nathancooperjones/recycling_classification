from setuptools import find_packages, setup

with open('recycling_classification/_version.py') as version_file:
    exec(version_file.read())

with open('README.md') as r:
    readme = r.read()

setup(
    name='recycling_classification',
    version=__version__,
    description='using deep learning to identify recyclable items',
    long_description=readme,
    packages=find_packages(exclude=('tests', 'docs')),
    install_requires=[
    ]
)
