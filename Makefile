

TAG=amarburg/minback-mongo

all: build push

build:
	docker build -t ${TAG} .

push:
	docker push ${TAG}

.PHONY: build push all
