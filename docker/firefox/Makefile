HOME_PATH ?= ${HOME}/doc/secure/firefox/home
LANG ?= ${LANG}

help:
	@echo "make build|run"

build:
	docker build -t firefox:latest .

clean:
	rm -rf ${HOME_PATH}

prepare:
	mkdir -p ${HOME_PATH}

run: prepare
	docker run --rm \
    -e DISPLAY="${DISPLAY}" -e LANG="${LANG}" \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v ${HOME_PATH}:/firefox/ \
    --name Firefox \
    --ipc=host \
    firefox:latest
