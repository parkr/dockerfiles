workflow "Build curl on push" {
  on = "push"
  resolves = ["Test curl"]
}

action "Build curl" {
  uses = "actions/docker/cli@master"
  args = "build-curl"
  runs = "make"
}

action "Test curl" {
  uses = "actions/docker/cli@master"
  needs = ["Build curl"]
  runs = "make"
  args = "test-curl"
}
