FROM ruby:alpine

RUN adduser -D -g '' docker

COPY . /code
WORKDIR /code

RUN apk add -U make git && make dependencies

USER docker
