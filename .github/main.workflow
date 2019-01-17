###
# GitHub Actions for parkr/dockerfiles
###

########################################################
#### Image: curl
########################################################

workflow "Build & test curl on push" {
  on = "push"
  resolves = ["Test curl"]
}

action "Test curl" {
  uses = "./.github/actions/docker-make"
  args = "test-curl"
}

workflow "Publish curl on push to master" {
  on = "push"
  resolves = ["Publish curl"]
}

action "Publish curl" {
  uses = "./.github/actions/docker-make"
  needs = ["Test curl", "Docker Login"]
  args = "publish-curl"
}
