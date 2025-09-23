#!/usr/bin/env bash

set -e

jsonschema validate --default-dialect "$SCHEMA_DIALECT" "$SCHEMA_PATH" "$YAML_FILE" --json > "$RESULTS_PATH" || true

verdict=$(jq -r '.valid' "$RESULTS_PATH")
if [[ "$verdict" == "true" ]]; then
	echo "YAML file is valid"
	exit 0
fi

NL="%0A"
validation_errors=""

jq -rc '.errors[]' "$RESULTS_PATH"

for entry in $(jq -rc '.errors[]' "$RESULTS_PATH"); do
	if [[ -z "$entry" ]]; then
		continue
	fi

	keywork_location=$(echo "$entry" | jq -r '.keywordLocation')
	instance_location=$(echo "$entry" | jq -r '.instanceLocation')
	error=$(echo "$entry" | jq -r '.error')

	validation_errors+="$NL- Error: $error"
	validation_errors+="$NL  Keyword location: $keywork_location"
	validation_errors+="$NL  Instance location: $instance_location" 
done

echo "::error title=YAML validation failed::Validation of YAML file '$YAML_FILE' has failed due to:$validation_errors"
exit 2
