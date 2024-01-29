# This container contains flutter version 3.16.0 for the development process. 
# Do not forget to build the image before launching the container.
#
# Build image example command:
# docker build . -t flutter:3.16.0

FROM dart:stable-sdk

RUN apt-get update \
    && apt-get install -y --no-install-recommends curl wget git unzip xz-utils zip libglu1-mesa \ 
    && rm -rf /var/lib/apt/lists/*

RUN git clone --depth 1 --branch 3.16.0 https://github.com/flutter/flutter.git /flutter

ENV PATH "$PATH:/flutter/bin"

RUN flutter doctor -v
