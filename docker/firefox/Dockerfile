FROM ubuntu:latest

RUN apt-get update && apt-get install -y locales

RUN echo -n "en_GB.UTF-8 UTF-8\nfr_FR.UTF-8 UTF-8\nen_US.UTF-8 UTF-8" > /etc/locale.gen
RUN locale-gen

ENV LANG en_GB.UTF-8
ENV LC_ALL en_GB.UTF-8

RUN apt-get install -y \
            fonts-dejavu-core \
		    fonts-freefont-ttf \
		    fonts-liberation \
		    fonts-noto \
		    fonts-noto-cjk \
		    fonts-noto-hinted \
		    fonts-noto-mono \
		    fonts-noto-unhinted

RUN apt-get install -y --no-install-recommends firefox

RUN useradd -d /firefox -m firefox

USER firefox

ENTRYPOINT ["/usr/bin/firefox"]
