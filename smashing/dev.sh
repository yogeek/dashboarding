# Set image name and local port
export smashing_image=smashing-dev
export smashing_image_version=latest

# Build dev environment
docker build -t ${smashing_image}:${smashing_image_version} $(pwd)/dev

# Launch by mounting a local dir as a volume to edit source code locally
mkdir -p mysmashing
docker run --rm -it -v $(pwd)/mysmashing:/home/dev/mysmashing -p 3030:3030 ${smashing_image}:${smashing_image_version} bash