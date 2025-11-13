
build:
	docker build -t app .
	docker run -dp 3000:3000 app
