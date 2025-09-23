#!/usr/bin/env bash

set -e

if [ -n "$SCHEMA_INPUT" ]; then
	echo "Using provided schema URI"
	echo "uri=$SCHEMA_INPUT" >> $GITHUB_OUTPUT
	exit 0
fi
echo "No schema URI provided, trying to extract it from the YAML file"

REGEXP="# *yaml-language-server: *.schema=(.*)"

while IFS= read -r line; do
	if [[ $line =~ $REGEXP ]]; then
	echo "uri=${BASH_REMATCH[1]}" >> $GITHUB_OUTPUT
	exit 0
	fi
done < "$TARGET_FILE"

echo "::error::No schema URL found in $TARGET_FILE"
exit 1
