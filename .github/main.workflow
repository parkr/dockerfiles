workflow "Build airconnect on push" {
  on = "push"
  resolves = ["Test airconnect"]
}

action "Build" {
  uses = "actions/docker/cli@master"
  args = "build-airconnect"
  runs = "make"
}

action "Test airconnect" {
  uses = "actions/docker/cli@master"
  needs = ["Build"]
  runs = "make"
  args = "test-airconnect"
}
