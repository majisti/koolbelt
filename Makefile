IMAGE_NAME=majisti/koolbelt

generate-versions:
	docker build . -t $(IMAGE_NAME) && docker run --rm -it -u node -v $(PWD):/opt/generated $(IMAGE_NAME) node generate-versions.js
