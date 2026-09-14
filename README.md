# Validate YAML

Composite action that validates a YAML file against JSON schema.

Under the hood it uses [jsonschema CLI](https://github.com/sourcemeta/jsonschema) to perform the validation.

To specify the schema, you should use the `yaml-language-server` comment like this:

```yaml
# yaml-language-server: $schema=[URI]
abc:
  def: ghi
klm:
  - nop
  - qrs
```

The URI can be a local file (e.g. `some/path/to/schema.json`) or a remote one (e.g. `https://json.schemastore.org/github-workflow.json`).

> [!TIP]
> This comment syntax is created and supported by [YAML Language Support by Red Hat](https://marketplace.visualstudio.com/items?itemName=redhat.vscode-yaml) VSCode extension, so you can get validation in your editor as well.

## Usage

```yaml
uses: cdqag/action-validate-yaml@v1
with:
  file: path/to/file.yaml
```

## Inputs

| Name | Description | Required | Default |
|---|---|---|---|
| `file` | Path to the YAML file to validate. | **Yes** | |
| `schema` | JSON schema to validate against. If not provided, the action will try to extract it from the YAML file using the comment `# yaml-language-server: $schema=URL`. | No | empty string |
| `schema-dialect` | JSON schema dialect. Only used if not provided in the schema. Value must have format: `https://json-schema.org/[path]/schema` | No | empty string |

## About Creator

![CDQ Logo](https://www.cdq.com/themes/custom/gavias_nonid/logo.svg)

This action has been created and is maitained by [CDQ - Data Quality Solutions &amp; Services for Master Data](https://www.cdq.com/).

## License

This project is licensed under the Apache-2.0 License. See the [LICENSE](LICENSE) file for details.
