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
    "Test silence-but-for-error",
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
    "Publish silence-but-for-error",
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
  runs = "/docker_tag_exists.sh"
  args = ["airconnect", "--", "make", "publish-airconnect"]
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
  runs = "/docker_tag_exists.sh"
  args = ["checkup", "--", "make", "publish-checkup"]
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
  runs = "/docker_tag_exists.sh"
  args = ["curl", "--", "make", "publish-curl"]
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
  runs = "/docker_tag_exists.sh"
  args = ["monicahq", "--", "make", "publish-monicahq"]
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
  runs = "/docker_tag_exists.sh"
  args = ["octodns", "--", "make", "publish-octodns"]
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
  runs = "/docker_tag_exists.sh"
  args = ["puppet-lint", "--", "make", "publish-puppet-lint"]
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
  runs = "/docker_tag_exists.sh"
  args = ["rclone", "--", "make", "publish-rclone"]
}

########################################################
#### Image: silence-but-for-error
########################################################

action "Test silence-but-for-error" {
  uses = "./.github/actions/docker-make"
  args = "test-silence-but-for-error"
}

action "Publish silence-but-for-error" {
  uses = "./.github/actions/docker-make"
  needs = [
    "Docker Login",
  ]
  runs = "/docker_tag_exists.sh"
  args = ["southwestcheckin", "--", "make", "publish-silence-but-for-error"]
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
  runs = "/docker_tag_exists.sh"
  args = ["southwestcheckin", "--", "make", "publish-southwestcheckin"]
}
