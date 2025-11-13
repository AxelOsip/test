

build:
	docker build -t app .


run_local: build
	docker run -dp 3000:3000 \
		-v "D:\workspace\virtual:/app" \
		-e USE_LOCAL=true \
		app \


run_remote: build
	docker run -dp 2999:3000 app
