help:
	cat Makefile

# build or rebuild the services WITHOUT cache
build:
	docker-compose stop || true; docker-compose rm || true;
	docker-compose build --force-rm --no-cache

# rebuild the services WITH cache
quick-build:
	docker-compose stop || true;
	docker-compose build 

# start (or restart) the services
server:
	docker-compose down || true;
	docker-compose up

# convert word & nb without Jekyll services
convert:
	docker-compose up converter

# stop all containers
stop: .FORCE
	docker-compose stop  || true; docker-compose rm || true;

# get shell inside the notebook service
bash-nb: .FORCE
	docker-compose exec watcher /bin/bash

# get shell inside jekyll service
bash-jekyll: .FORCE
	docker-compose exec jekyll /bin/bash

.FORCE: