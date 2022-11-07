#!/bin/bash

docker --version
docker login --username $DOCKER_HUB_USER --password $DOCKER_HUB_PASS
curl -L https://raw.githubusercontent.com/docker/compose-cli/main/scripts/install/install_linux.sh | sh
docker-compose -f docker-compose.build.yml build
docker-compose -f docker-compose.build.yml push
docker context create ecs deploy-phoenix --from-env
docker context use deploy-phoenix
docker-compose -f docker-compose.prod.yml up




