#!/bin/sh

if test "$GITHUB_ACTIONS" = "true"
then
	CI_TYPE=github-actions
fi
