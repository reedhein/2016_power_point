docker kill lets-nginx
docker rm lets-nginx
docker run --detach \
  --name lets-nginx \
  --link power_point:power_point \
  --env EMAIL=doug@reedhein.com \
  --env DOMAIN=hipsterelixer.com \
  --env UPSTREAM=power_point:4567 \
  --publish 80:80 \
  --publish 443:443 \
  smashwilson/lets-nginx
