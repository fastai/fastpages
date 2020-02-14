
help:
	cat Makefile

# build the conversion service
build:
	docker stop fastpages-dev || true; docker rm fastpages-dev || true;
	docker-compose -f convert-docker-compose.yaml  build --no-cache

# Start Jekyll Server
run-server:
	docker-compose up

# convert word & nb files
convert:
	docker-compose -f convert-docker-compose.yaml up

# stop all containers
stop: .FORCE
	docker stop fastpages-dev || true; docker rm fastpages-dev || true;
	docker stop jekyll || true; docker rm jekyll || true;

# rebuild the container
rebuild: stop .FORCE
	docker-compose -f convert-docker-compose.yaml build --force-rm

# get shell inside fastpages environment
bash-fastpages: .FORCE
	docker stop fastpages-dev || true; docker rm fastpages-dev || true;
	docker-compose -f convert-docker-compose.yaml run --name fastpages-dev fastpages /bin/bash

# get shell inside jekyll server
bash-jekyll: .FORCE
	docker-compose exec jekyll bash

.FORCE: