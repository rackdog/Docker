./generate-publish-folder.sh
./get-latest-db.sh
docker compose down -v
docker compose up --build -d
