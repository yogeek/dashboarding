# Gatus

https://github.com/TwinProduction/gatus

A service health dashboard in Go that is meant to be used as a docker image with a custom configuration file.

## Usage

### Minimal

cd minimal
docker run -p 8080:8080 --mount type=bind,source="$(pwd)"/config.yaml,target=/config/config.yaml --name gatus twinproduction/gatus