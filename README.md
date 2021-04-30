# development_bootstrap
Files helpful for setting up my development environment. These allow me to
create Docker images from any machine via Dockerfiles that have my development
environment in them so that I can pick up and develop on my Mac or some Linux
machine quickly.

# Layout

* `Dockerfiles` contain the set of
  [Dockerfile](https://docs.docker.com/engine/reference/builder/) files for
  various build environments.
* 

# Steps

1. Review the Dockerfile for the environment development is for and make any
   desired changes. For example, for ATS read
   [docker/ats/Dockerfile](docker/ats/Dockerfile).
1. Review
1. Create a local docker image: `bash docker/image_creation_scripts/make_ats_dev_image <ats_dev_image>`
1. With your new local image, you can now create a tmux build environment with: `bash bin/new_ats_project <ats_dev_image> <desired_branch_name>`
