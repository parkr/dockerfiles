# dockerfiles

Dockerfiles for many of the images hosted at my username on Docker Hub.

## Background

There are several utilities that I would like to use but for which either Docker images aren't published, or I don't want to have to trust their images.

Instead of finding some random image that someone else wrote for the utility, most are simple enough to replicate minimally and self-publish.

## Usage

All Docker images are built with GitHub Actions and pushed to Docker Hub on merge to main.

To do something locally, you can use `make`:

```console
$ make build-curl # builds the docker image for `curl` subdirectory
$ make test-curl # builds the docker image for `curl` subdirectory and runs tests
$ make dive-curl # builds the docker image for `curl` subdirectory and opens the resulting image in `dive` (to inspect filesystem)
$ make publish-curl # builds the docker image for `curl` subdirectory and publishes to Docker Hub
```

## Adding a New Image

To create a new image, all you need to do is:

1. Create the subdirectory for your project (it will map to `parkr/$dir` as the image name), with `Dockerfile`, `VERSION`, and `test.sh` files.
2. Fill out the `VERSION` file for your desired version. It can be a Git SHA-1, a semver version, etc.
3. Write the `Dockerfile` to accept a build argument `VERSION` and use that to fetch the program at the given version. When you want the default branch of a project, be sure to use `latest` in `VERSION`, and map that to the default branch in your `Dockerfile`. 
4. Write `test.sh` to exit 1 if the Docker image isn't working. This might be a Docker `HEALTHCHECK` that you verify is healthy upon starting the image, or maybe it's as simple as making sure the utility file is installed and executable.
5. Add the entries to `.github/actions` files. Copying a pre-existing utility's actions/steps in the file will help. Let's keep these files alphabetical.
6. Push to a feature branch.
7. Verify tests pass, then merge.

## License

This repository uses the MIT License.
