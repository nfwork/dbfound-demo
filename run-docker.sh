#!/usr/bin/env bash
set -euo pipefail

APP_NAME="${APP_NAME:-$(mvn -q -DforceStdout help:evaluate -Dexpression=project.artifactId)}"
HOST_PORT="${HOST_PORT:-8080}"

mvn clean package

docker build --build-arg WAR_FILE="target/${APP_NAME}.war" -t "${APP_NAME}" .

if docker ps -a --format '{{.Names}}' | grep -Fxq "${APP_NAME}"; then
	docker rm -f "${APP_NAME}"
fi

docker run --name "${APP_NAME}" -p "${HOST_PORT}:8080" "${APP_NAME}"
