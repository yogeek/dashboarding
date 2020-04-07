# Port 19999
docker-compose up -d

NETDATA_URL="http://localhost:19999"
echo "Opening Netdata..."
xdg-open "${NETDATA_URL}"