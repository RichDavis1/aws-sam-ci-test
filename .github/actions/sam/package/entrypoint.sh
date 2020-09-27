#!/bin/bash

set -e

cd $INPUT_WORKING_DIRECTORY

# Respect AWS_DEFAULT_REGION if specified
[ -n "$AWS_DEFAULT_REGION" ] || export AWS_DEFAULT_REGION=us-east-1

# Respect AWS_DEFAULT_OUTPUT if specified
[ -n "$AWS_DEFAULT_OUTPUT" ] || export AWS_DEFAULT_OUTPUT=json

ARGS=()

(( -z "$PREFIX" )) && args+=( "--prefix $PREFIX")

ARGS+=( "--s3-bucket $INPUT_BUCKET" )
ARGS+=( "--template-file $INPUT_TEMPLATE_FILE" )
ARGS+=( "--output-template-file $INPUT_OUTPUT_TEMPLATE_FILE" )

CMD="sam package ${ARGS[@]}"

output=$( sh -c "$CMD" )

# Preserve output for consumption by downstream actions
echo "$output" > "${HOME}/${GITHUB_ACTION}.${AWS_DEFAULT_OUTPUT}"

# Write output to STDOUT
echo "$output"
