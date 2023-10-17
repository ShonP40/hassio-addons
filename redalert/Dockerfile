FROM ubuntu:18.04

LABEL maintainer="Docker@shon.codes"

# Install dependencies
RUN apt update

RUN apt install -yqq python3-pip jq

RUN pip3 install --upgrade pip setuptools  --no-cache-dir && \
    pip3 install paho-mqtt --no-cache-dir && \
    pip3 install urllib3 --no-cache-dir && \
    pip3 install loguru --no-cache-dir && \
    pip3 install apprise --no-cache-dir

# Configure the environment
ENV PYTHONIOENCODING=utf-8

ENV LANG=C.UTF-8

#Debug Mode for testing
ENV DEBUG_MODE "False"

# Create working directory
RUN mkdir /opt/redalert

COPY redalert.py /opt/redalert

# Run
COPY run.sh /
RUN chmod a+x /run.sh
CMD [ "/run.sh" ]