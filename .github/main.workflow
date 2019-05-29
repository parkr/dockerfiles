###
# GitHub Actions for parkr/dockerfiles
###

action "Docker Login" {
  uses = "actions/docker/login@master"
  needs = ["On master branch"]
  secrets = [
    "DOCKER_USERNAME",
    "DOCKER_PASSWORD",
  ]
}

action "GitHub Package Registry Login" {
  uses = "./.github/actions/github-pkg-login"
  secrets = [
    "GPR_USERNAME",
    "GPR_PASSWORD",
  ]
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
    "Test git",
    "Test monicahq",
    "Test octodns",
    "Test puppet-lint",
    "Test rclone",
    "Test silence-but-for-error",
    "Test southwestcheckin",
  ]
}

workflow "Publish to Docker Hub on push to master" {
  on = "push"
  resolves = [
    "Publish airconnect",
    "Publish checkup",
    "Publish curl",
    "Publish git",
    "Publish monicahq",
    "Publish octodns",
    "Publish puppet-lint",
    "Publish rclone",
    "Publish silence-but-for-error",
    "Publish southwestcheckin",
  ]
}

workflow "Publish to GitHub Package Registry on push to master" {
  on = "push"
  resolves = [
    "Publish airconnect to GitHub Package Registry",
    "Publish checkup to GitHub Package Registry",
    "Publish curl to GitHub Package Registry",
    "Publish git to GitHub Package Registry",
    "Publish monicahq to GitHub Package Registry",
    "Publish octodns to GitHub Package Registry",
    "Publish puppet-lint to GitHub Package Registry",
    "Publish rclone to GitHub Package Registry",
    "Publish silence-but-for-error to GitHub Package Registry",
    "Publish southwestcheckin to GitHub Package Registry",
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
  args = ["publish-airconnect"]
}

action "Publish airconnect to GitHub Package Registry" {
  uses = "./.github/actions/docker-make"
  needs = [
    "GitHub Package Registry Login",
  ]
  args = ["publish-airconnect", "-e", "NAMESPACE=docker.pkg.github.com/parkr/dockerfiles", "-e", "TAG_PREFIX=sha-"]
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
  args = ["publish-checkup"]
}

action "Publish checkup to GitHub Package Registry" {
  uses = "./.github/actions/docker-make"
  needs = [
    "GitHub Package Registry Login",
  ]
  args = ["publish-checkup", "-e", "NAMESPACE=docker.pkg.github.com/parkr/dockerfiles", "-e", "TAG_PREFIX=sha-"]
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
  args = ["publish-curl"]
}

action "Publish curl to GitHub Package Registry" {
  uses = "./.github/actions/docker-make"
  needs = [
    "GitHub Package Registry Login",
  ]
  args = ["publish-curl", "-e", "NAMESPACE=docker.pkg.github.com/parkr/dockerfiles"]
}

########################################################
#### Image: git
########################################################

action "Test git" {
  uses = "./.github/actions/docker-make"
  args = "test-git"
}

action "Publish git" {
  uses = "./.github/actions/docker-make"
  needs = [
    "Docker Login",
  ]
  args = ["publish-git"]
}

action "Publish git to GitHub Package Registry" {
  uses = "./.github/actions/docker-make"
  needs = [
    "GitHub Package Registry Login",
  ]
  args = ["publish-git", "-e", "NAMESPACE=docker.pkg.github.com/parkr/dockerfiles"]
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
  args = ["publish-monicahq"]
}

action "Publish monicahq to GitHub Package Registry" {
  uses = "./.github/actions/docker-make"
  needs = [
    "GitHub Package Registry Login",
  ]
  args = ["publish-monicahq", "-e", "NAMESPACE=docker.pkg.github.com/parkr/dockerfiles"]
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
  args = ["publish-octodns"]
}

action "Publish octodns to GitHub Package Registry" {
  uses = "./.github/actions/docker-make"
  needs = [
    "GitHub Package Registry Login",
  ]
  args = ["publish-octodns", "-e", "NAMESPACE=docker.pkg.github.com/parkr/dockerfiles"]
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
  args = ["publish-puppet-lint"]
}

action "Publish puppet-lint to GitHub Package Registry" {
  uses = "./.github/actions/docker-make"
  needs = [
    "GitHub Package Registry Login",
  ]
  args = ["publish-puppet-lint", "-e", "NAMESPACE=docker.pkg.github.com/parkr/dockerfiles"]
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
  args = ["publish-rclone"]
}

action "Publish rclone to GitHub Package Registry" {
  uses = "./.github/actions/docker-make"
  needs = [
    "GitHub Package Registry Login",
  ]
  args = ["publish-rclone", "-e", "NAMESPACE=docker.pkg.github.com/parkr/dockerfiles"]
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
  args = ["publish-silence-but-for-error"]
}

action "Publish silence-but-for-error to GitHub Package Registry" {
  uses = "./.github/actions/docker-make"
  needs = [
    "GitHub Package Registry Login",
  ]
  args = ["publish-silence-but-for-error", "-e", "NAMESPACE=docker.pkg.github.com/parkr/dockerfiles"]
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
  args = ["publish-southwestcheckin"]
}

action "Publish southwestcheckin to GitHub Package Registry" {
  uses = "./.github/actions/docker-make"
  needs = [
    "GitHub Package Registry Login",
  ]
  args = ["publish-southwestcheckin", "-e", "NAMESPACE=docker.pkg.github.com/parkr/dockerfiles", "-e", "TAG_PREFIX=sha-"]
}
