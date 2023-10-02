## youtube-dl-nightly

Repackaged this software into a Docker container. Use it thusly:

```text
docker run --rm -v "$(pwd)":/youtube-dl parkr/youtube-dl-nightly:TAG <args>
```

Latest TAG can be found on [Docker Hub](https://hub.docker.com/r/parkr/youtube-dl-nightly/tags).
