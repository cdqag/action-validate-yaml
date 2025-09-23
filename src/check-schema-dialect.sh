#!/usr/bin/env bash

set -e

SCHEMA_DIALECT=$(jq -r '.["$schema"]' "$SCHEMA_PATH")
if [ "$SCHEMA_DIALECT" == "null" ]; then
	SCHEMA_DIALECT="$SCHEMA_DIALECT_INPUT"
fi

if [ -z "$SCHEMA_DIALECT" ]; then
	echo "::error::No schema dialect provided or found in the schema"
	exit 1
fi

echo "dialect=$SCHEMA_DIALECT" >> $GITHUB_OUTPUT
