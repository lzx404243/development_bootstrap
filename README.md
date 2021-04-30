# development_bootstrap
Files helpful for setting up my development environment. These allow me to
create Docker images from any machine via Dockerfiles that have my development
environment in them so that I can pick up and develop on my Mac or some Linux
machine quickly.

# Layout

* `Dockerfiles` contains the set of
  [Dockerfile](https://docs.docker.com/engine/reference/builder/) files for
  various build environments.
* `docker_context` contains rc and other user environment files to copy into
  the image. They are hidden . files, so do an `ls -la` to view them.
* `scripts` contains scripts to build docker images and containers.

# Steps

1. Review the hidden `.` files in `docker_context` and make any desired
   changes, additions, or subtractions.
1. Review the specific `Dockerfile` for the environment you're building and
   make any desired changes.  For example, for ATS, review
   [docker/ats/Dockerfile](docker/ats/Dockerfile).  Changes in `docker_context`
   may necessitate changes here, such as calling `COPY` and `chown` for any
   new files you add to the context.
1. Create a local docker image:
   `bash scripts/build_ats_image <new_image_name> "<Your Git User Name>" <your.git@email.com>`
1. With your new local image, you can now create a container and tmux session
   inside it via:
   `bash scripts/make_ats_container <new_image_name> <new_container_name>`
