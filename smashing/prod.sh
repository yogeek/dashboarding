# Set image name and local port
export smashing_image=smashing-prod
export smashing_image_version=latest

# Build dev environment
docker build -t ${smashing_image}:${smashing_image_version} $(pwd)/prod

# Launch by mounting a local dir as a volume to edit source code locally
docker run --rm -it -p 3030:3030 ${smashing_image}:${smashing_image_version}