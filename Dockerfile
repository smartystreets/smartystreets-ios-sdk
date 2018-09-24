FROM ruby:alpine
WORKDIR /code
COPY . .
RUN apk add -U make git \
	&& wget -q -O - "bit.ly/version-tools" | sh \
	&& gem install cocoapods \
	&& adduser -D -g '' docker
USER docker
