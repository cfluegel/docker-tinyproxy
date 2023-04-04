DOCKER_USERNAME ?= cfluegel
APPLICATION_NAME ?= tinyproxy
GIT_HASH ?= $(shell git log --format="%h" -n 1)


build:
	docker build -t ${DOCKER_USERNAME}/${APPLICATION_NAME}:latest . 

test: 
	docker run --name tinyproxy -e LISTENPORT=7777 -e "ALLOWEDRANGES=10.235.235.0/24,192.168.178.0/24" cfluegel/tinyproxy:latest
	docker container rm tinyproxy

