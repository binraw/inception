build:
	docker-compose -f srcs/docker-compose.yml build

up: 
	docker-compose -f srcs/docker-compose.yml up

start: 
	docker-compose -f srcs/docker-compose.yml start

down: 
	docker-compose -f srcs/docker-compose.yml down -v

stop: 
	docker-compose -f srcs/docker-compose.yml stop

restart:
	docker-compose -f srcs/docker-compose.yml stop
	docker-compose -f srcs/docker-compose.yml up -d 

logs: 
	docker-compose -f srcs/docker-compose.yml logs

ps: 
	docker-compose -f srcs/docker-compose ps

