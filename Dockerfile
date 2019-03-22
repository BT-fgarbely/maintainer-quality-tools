FROM debian:stretch
LABEL maintainer=""

# Generate locale C.UTF-8 for postgres and general locale data
ENV LANG C.UTF-8
ENV VERSION "11.0"
ENV TESTS "0"
ENV LINT_CHECK "1"
ENV TRANSIFEX "0"
RUN apt-get update && apt-get install -y --no-install-recommends python-pip wget python-dev curl
RUN pip install setuptools wheel
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - 
RUN apt-get update && apt-get install -y git nodejs
COPY . /root/maintainer-quality-tools
RUN export PATH=${HOME}/maintainer-quality-tools/travis:${PATH} \
    && travis_install_nightly

RUN cd /usr/bin && ln -s /root/maintainer-quality-tools/travis/travis_run_tests
COPY ./entrypoint.sh /entrypoint.sh
CMD ["/entrypoint.sh"]
