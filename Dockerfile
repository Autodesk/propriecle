FROM python:2.7

MAINTAINER 'Jonathan Freedman <jonathan.freedman@autodesk.com>'
ARG VERSION=0.0.0

LABEL license="MIT"
LABEL version="${VERSION}"

RUN apt-get update && apt-get install -y gnupg2
ADD . /tmp/propriecle
ADD scripts/docker-entrypoint /usr/local/bin/docker-entrypoint

RUN cd /tmp/propriecle && python setup.py install && cd /tmp && rm -rf /tmp/propriecle

ENTRYPOINT ["docker-entrypoint"]
