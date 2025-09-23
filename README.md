# Validate YAML

Composite action that validates a YAML file against JSON schema.

Might be useful when you need to download a file from a repository in a GitHub Actions context, and you don't want to clone the whole repository.

Dependencies: `curl` and `jq` must be installed in the environment where this action is being used.

## Usage

Example of downloading a file from the same repository where the action is being used:

```yaml
- name: Get myFile.txt from this repository
  uses: cdqag/action-download-repository-file@v1
    with:
      file: some-directory/sub-directory/myFile.txt
```

Example of downloading a file from a different repository:

```yaml
- name: Get myFile.txt from another repository
  uses: cdqag/action-download-repository-file@v1
    with:
      repository: owner/repo
      file: some-directory/sub-directory/myFile.txt
      destination: custom-file-name.txt
      github-token: ${{ steps.get-token.outputs.token }}  # Note: You need to provide a token with access to the repository. Default `${{ github.token }}` only has access to the current repository!
```

## Inputs

| Name | Description | Required | Default |
|---|---|---|---|
| `github-token` | GitHub token that will be used to download the file| No | Default GitHub Token with access only to current repository |
| `repository` | GitHub repository name in format `owner/repo-name` | No | Current repository |
| `file` | Path to the file (relative to the repository root) | **Yes** | |
| `destination` | Where to store the downloaded file contents| No | Name of the downloaded file |

## License

This project is licensed under the Apache-2.0 License. See the [LICENSE](LICENSE) file for details.
