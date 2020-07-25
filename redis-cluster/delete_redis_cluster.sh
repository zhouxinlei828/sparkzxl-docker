#
for port in `seq 6391 6396`; do
docker stop "redis-"${port}
sleep 1
docker rm "redis-"${port}
done

