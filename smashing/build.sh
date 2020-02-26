# Set image name and local port
export smashing_image=smashing
export smashing_image_version=latest
# Launch locally
docker build -t ${smashing_image}:${smashing_image_version} ./dockerfile