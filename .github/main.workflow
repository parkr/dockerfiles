###
# GitHub Actions for parkr/dockerfiles
###

action "Docker Login" {
  uses = "actions/docker/login@master"
  needs = ["On master branch"]
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
}

action "On master branch" {
  uses = "actions/bin/filter@master"
  args = "branch master"
}

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

action "Publish curl" {
  uses = "./.github/actions/docker-make"
  needs = [
    "Test curl",
    "Docker Login",
  ]
  args = "publish-curl"
}

########################################################
#### Image: octodns
########################################################

workflow "Build & test octodns on push" {
  on = "push"
  resolves = [
    "Test octodns",
    "Publish octodns",
  ]
}

action "Test octodns" {
  uses = "./.github/actions/docker-make"
  args = "test-octodns"
}

action "Publish octodns" {
  uses = "./.github/actions/docker-make"
  needs = [
    "Test octodns",
    "Docker Login",
  ]
  args = "publish-octodns"
}

########################################################
#### Image: rclone
########################################################

workflow "Build & test rclone on push" {
  on = "push"
  resolves = [
    "Test rclone",
    "Publish rclone",
  ]
}

action "Test rclone" {
  uses = "./.github/actions/docker-make"
  args = "test-rclone"
}

action "Publish rclone" {
  uses = "./.github/actions/docker-make"
  needs = [
    "Test rclone",
    "Docker Login",
  ]
  args = "publish-rclone"
}
