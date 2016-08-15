docker kill power_point
docker rm power_point
docker build -t power_point ./
docker run -d \
  -p 4567:4567 \
  --name power_point \
  power_point
