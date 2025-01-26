#!/usr/bin/env sh
set -eu

/setup-ssh.sh

export GIT_SSH_COMMAND="ssh -v -i ~/.ssh/id_rsa -o StrictHostKeyChecking=no -l $INPUT_SSH_USERNAME"
git remote add mirror "$INPUT_TARGET_REPO_URL"
# this started to fail as refs/remotes/origin/HEAD can not be pushed
# $ git push --tags --force --prune mirror "refs/remotes/origin/*:refs/heads/*"
git push -v --tags --force --prune origin_gitlab "refs/remotes/origin/*:refs/heads/*" ":refs/heads/HEAD"

# NOTE: Since `post` execution is not supported for local action from './' for now, we need to
# run the command by hand.
/cleanup.sh mirror
