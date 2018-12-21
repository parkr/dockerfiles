FROM alpine as cloner
RUN apk update && apk add git
ARG GIT_REVISION
RUN git clone https://github.com/pyro2927/SouthwestCheckin /tmp/SouthwestCheckin && \
  git --git-dir=/tmp/SouthwestCheckin/.git --work-tree=/tmp/SouthwestCheckin checkout $GIT_REVISION

FROM python:3.6-alpine
COPY --from=cloner /tmp/SouthwestCheckin /tmp/SouthwestCheckin
WORKDIR /tmp/SouthwestCheckin
RUN pip install -r requirements.txt
ENTRYPOINT [ "python", "/tmp/SouthwestCheckin/checkin.py" ]
