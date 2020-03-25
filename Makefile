help:
	cat Makefile

# start (or restart) the services
server: .FORCE
	docker-compose down --remove-orphans || true;
	docker-compose up

# start (or restart) the services in detached mode
server-detached: .FORCE
	docker-compose down || true;
	docker-compose up -d

# build or rebuild the services WITHOUT cache
build: .FORCE
	docker-compose stop || true; docker-compose rm || true;
	docker build -t hamelsmu/fastpages-jekyll -f _action_files/fastpages-jekyll.Dockerfile .
	docker-compose build --force-rm --no-cache

# rebuild the services WITH cache
quick-build: .FORCE
	docker-compose stop || true;
	docker build -t hamelsmu/fastpages-jekyll -f _action_files/fastpages-jekyll.Dockerfile .
	docker-compose build 

# convert word & nb without Jekyll services
convert: .FORCE
	docker-compose up converter

# stop all containers
stop: .FORCE
	docker-compose stop
	docker ps | grep fastpages | awk '{print $1}' | xargs docker stop

# remove all containers
remove: .FORCE
	docker-compose stop  || true; docker-compose rm || true;

# get shell inside the notebook converter service (Must already be running)
bash-nb: .FORCE
	docker-compose exec watcher /bin/bash

# get shell inside jekyll service (Must already be running)
bash-jekyll: .FORCE
	docker-compose exec jekyll /bin/bash

# restart just the Jekyll server
restart-jekyll: .FORCE
	docker-compose restart jekyll

.FORCE:
