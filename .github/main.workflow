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

workflow "Build & test on push" {
  on = "push"
  resolves = [
    "Test airconnect",
    "Test checkup",
    "Test curl",
    "Test monicahq",
    "Test octodns",
    "Test puppet-lint",
    "Test rclone",
    "Test southwestcheckin",
  ]
}

workflow "Publish on push to master" {
  on = "push"
  resolves = [
    "Publish airconnect",
    "Publish checkup",
    "Publish curl",
    "Publish monicahq",
    "Publish octodns",
    "Publish puppet-lint",
    "Publish rclone",
    "Publish southwestcheckin",
  ]
}

########################################################
#### Image: airconnect
########################################################

action "Test airconnect" {
  uses = "./.github/actions/docker-make"
  args = "test-airconnect"
}

action "Publish airconnect" {
  uses = "./.github/actions/docker-make"
  needs = [
    "Docker Login",
  ]
  args = "publish-airconnect"
}

########################################################
#### Image: checkup
########################################################

action "Test checkup" {
  uses = "./.github/actions/docker-make"
  args = "test-checkup"
}

action "Publish checkup" {
  uses = "./.github/actions/docker-make"
  needs = [
    "Docker Login",
  ]
  args = "publish-checkup"
}

########################################################
#### Image: curl
########################################################

action "Test curl" {
  uses = "./.github/actions/docker-make"
  args = "test-curl"
}

action "Publish curl" {
  uses = "./.github/actions/docker-make"
  needs = [
    "Docker Login",
  ]
  args = "publish-curl"
}

########################################################
#### Image: monicahq
########################################################

action "Test monicahq" {
  uses = "./.github/actions/docker-make"
  args = "test-monicahq"
}

action "Publish monicahq" {
  uses = "./.github/actions/docker-make"
  needs = [
    "Docker Login",
  ]
  args = "publish-monicahq"
}

########################################################
#### Image: octodns
########################################################

action "Test octodns" {
  uses = "./.github/actions/docker-make"
  args = "test-octodns"
}

action "Publish octodns" {
  uses = "./.github/actions/docker-make"
  needs = [
    "Docker Login",
  ]
  args = "publish-octodns"
}

########################################################
#### Image: puppet-lint
########################################################

action "Test puppet-lint" {
  uses = "./.github/actions/docker-make"
  args = "test-puppet-lint"
}

action "Publish puppet-lint" {
  uses = "./.github/actions/docker-make"
  needs = [
    "Docker Login",
  ]
  args = "publish-puppet-lint"
}

########################################################
#### Image: rclone
########################################################

action "Test rclone" {
  uses = "./.github/actions/docker-make"
  args = "test-rclone"
}

action "Publish rclone" {
  uses = "./.github/actions/docker-make"
  needs = [
    "Docker Login",
  ]
  args = "publish-rclone"
}

########################################################
#### Image: southwestcheckin
########################################################

action "Test southwestcheckin" {
  uses = "./.github/actions/docker-make"
  args = "test-southwestcheckin"
}

action "Publish southwestcheckin" {
  uses = "./.github/actions/docker-make"
  needs = [
    "Docker Login",
  ]
  args = "publish-southwestcheckin"
}
