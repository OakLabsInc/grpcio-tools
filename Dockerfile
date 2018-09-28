FROM python:3.7.0-alpine

RUN apk --no-cache add python-dev build-base

RUN pip install grpcio-tools==1.15.0
