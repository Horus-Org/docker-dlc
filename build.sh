run -p 8080:8080 -d -t -i -v $PWD:/app -w /app node:12-alpine npm run start
run -p 8080:8080 -d -t -i -v $PWD:/app -w /app node:12-alpine cargo run
