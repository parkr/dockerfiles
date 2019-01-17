workflow "Build airconnect on push" {
  on = "push"
  resolves = ["Build"]
}

action "Build" {
  uses = "actions/docker/cli@master"
  args = "build -t parkr/airconnect:$$GITHUB_REVISION ."
}
