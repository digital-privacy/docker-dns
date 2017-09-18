all: build

build:
	@docker build --tag=einyx/bind .
