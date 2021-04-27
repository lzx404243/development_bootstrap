# development_bootstrap
Files helpful for setting up my development environment.

# ATS Steps:

1. Review the [Dockerfile](docker/ats/Dockerfile) for ATS and make any desired changes.
1. Create a local docker image: `bash docker/image_creation_scripts/make_ats_dev_image <ats_dev_image>`
1. With your new local image, you can now create a tmux build environment with: `bash bin/new_ats_project <ats_dev_image> <desired_branch_name>`
