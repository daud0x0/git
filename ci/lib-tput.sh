#!/bin/sh

# GitHub Action doesn't set TERM, which is required by tput
TERM=${TERM:-dumb}
export TERM
