FROM python:3-alpine
RUN set -ex \
  && apk add --no-cache build-base libffi-dev openssl-dev \
  && pip3 install --upgrade --no-cache-dir \
    homeassistant \
    colorlog==4.1.0 \
    home-assistant-frontend==20200220.5 \
    PyNaCl==1.3.0 \
    distro==1.4.0 \
    defusedxml==0.6.0 \
    netdisco==2.6.0 \
    hass-nabucasa==0.31 \
    aiohttp_cors==0.7.0 \
    HAP-python==2.7.0 \
    sqlalchemy==1.3.13 \
    mutagen==1.43.0 \
    gTTS-token==1.1.3 \
    zeroconf==0.24.4 \
  && rm -rf /root/.cache
ENTRYPOINT [ "/usr/local/bin/hass" ]
