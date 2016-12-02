#/bin/bash -ex

GITLAB_CI_URL=""
GITLAB_CI_TOKEN=""

gitlab-ci-multi-runner register \
  --url "$GITLAB_CI_URL" \
  --registration-token "$GITLAB_CI_TOKEN" \
  --description "robot-selenium-on-docker" \
  --tag-list "robot,selenium" \
  --executor "shell"

sleep 3
gitlab-ci-multi-runner status
