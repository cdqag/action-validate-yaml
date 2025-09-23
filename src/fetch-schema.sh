#!/usr/bin/env bash

set -e

HTTP_REGEXP="^https?://"

if ! [[ $SCHEMA_URI =~ $HTTP_REGEXP ]]; then
	echo "::debug::Schema URI is not an HTTP(S) - checking if it's a local file"
	
	if [ ! -f "$SCHEMA_URI" ]; then
		echo "::error::Schema URI is not a valid HTTP(S) URL or a local file: $SCHEMA_URI"
		exit 1
	fi

	echo "::debug::Schema URL is a local file"
	cp "$SCHEMA_URI" "$SCHEMA_PATH"

else
	echo "::debug::Schema URI is an HTTP(S) URL - downloading it"
	curl -sSL "$SCHEMA_URI" -o "$SCHEMA_PATH"
	if [ $? -ne 0 ]; then
		echo "::error::Failed to download schema from $SCHEMA_URI"
		exit 1
	fi
fi

echo "path=$SCHEMA_PATH" >> $GITHUB_OUTPUT
