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
#### Image: airconnect
########################################################

workflow "Build & test airconnect on push" {
  on = "push"
  resolves = [
    "Test airconnect",
    "Publish airconnect",
  ]
}

action "Test airconnect" {
  uses = "./.github/actions/docker-make"
  args = "test-airconnect"
}

action "Publish airconnect" {
  uses = "./.github/actions/docker-make"
  needs = [
    "Test airconnect",
    "Docker Login",
  ]
  args = "publish-airconnect"
}

########################################################
#### Image: checkup
########################################################

workflow "Build & test checkup on push" {
  on = "push"
  resolves = [
    "Test checkup",
    "Publish checkup",
  ]
}

action "Test checkup" {
  uses = "./.github/actions/docker-make"
  args = "test-checkup"
}

action "Publish checkup" {
  uses = "./.github/actions/docker-make"
  needs = [
    "Test checkup",
    "Docker Login",
  ]
  args = "publish-checkup"
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
#### Image: monicahq
########################################################

workflow "Build & test monicahq on push" {
  on = "push"
  resolves = [
    "Test monicahq",
    "Publish monicahq",
  ]
}

action "Test monicahq" {
  uses = "./.github/actions/docker-make"
  args = "test-monicahq"
}

action "Publish monicahq" {
  uses = "./.github/actions/docker-make"
  needs = [
    "Test monicahq",
    "Docker Login",
  ]
  args = "publish-monicahq"
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
#### Image: puppet-lint
########################################################

workflow "Build & test puppet-lint on push" {
  on = "push"
  resolves = [
    "Test puppet-lint",
    "Publish puppet-lint",
  ]
}

action "Test puppet-lint" {
  uses = "./.github/actions/docker-make"
  args = "test-puppet-lint"
}

action "Publish puppet-lint" {
  uses = "./.github/actions/docker-make"
  needs = [
    "Test puppet-lint",
    "Docker Login",
  ]
  args = "publish-puppet-lint"
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

########################################################
#### Image: southwestcheckin
########################################################

workflow "Build & test southwestcheckin on push" {
  on = "push"
  resolves = [
    "Test southwestcheckin",
    "Publish southwestcheckin",
  ]
}

action "Test southwestcheckin" {
  uses = "./.github/actions/docker-make"
  args = "test-southwestcheckin"
}

action "Publish southwestcheckin" {
  uses = "./.github/actions/docker-make"
  needs = [
    "Test southwestcheckin",
    "Docker Login",
  ]
  args = "publish-southwestcheckin"
}
