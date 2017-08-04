#!/usr/bin/env python
from setuptools import setup

setup(name='propriecle',
      version='0.0.0',
      description='something something vault master keys',
      author='Jonathan Freedman',
      author_email='jonathan.freedman@autodesk.com',
      license='MIT',
      url='https://github.com/autodesk/propriecle',
      install_requires=['PyYAML', 'hvac', 'future', 'cryptorito'],
      include_package_data=True,
      packages=['propriecle'],
      entry_points={
          'console_scripts': ['propriecle = propriecle.cli:main']
      }
)
