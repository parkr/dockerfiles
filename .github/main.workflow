###
# GitHub Actions for parkr/dockerfiles
###

########################################################
#### Image: curl
########################################################

workflow "Build & test curl on push" {
  on = "push"
  resolves = [
    "Test curl",
    "Publish curl",
  ]
}

action "Test curl" {
  uses = "./.github/actions/docker-make"
  args = "test-curl"
}

action "On master branch" {
  uses = "actions/bin/filter@master"
  args = "branch master"
}

action "Docker Login" {
  uses = "actions/docker/login@master"
  needs = ["On master branch"]
}

action "Publish curl" {
  uses = "./.github/actions/docker-make"
  needs = [
    "Test curl",
    "Docker Login",
  ]
  args = "publish-curl"
} ###

# GitHub Actions for parkr/dockerfiles
###
########################################################
#### Image: curl
########################################################
