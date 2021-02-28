# release-action

![Tests](https://github.com/sanjP10/release-action/workflows/Tests/badge.svg?branch=master)

This is an action that enables the use of the tool [release](https://github.com/sanjP10/release) in a github action.
This exposes the use of the tool with a github action interface.

## Variables

### Inputs

| Input                   | Description                                                                                           | Default  |
| ----------------------- |-------------------------------------------------------------------------------------------------------| --------|
| operation               | This defines what operation you would like to run via the release tool. Either `validate` or `create` | validate |
| user                    | User to use when validating/creating the release                                                      | [github.actor](https://docs.github.com/en/actions/reference/context-and-expression-syntax-for-github-actions#github-context) |
| token                   | Personal Access Token to use when validating/creating                                                 | [github.token](https://docs.github.com/en/actions/reference/context-and-expression-syntax-for-github-actions#github-context) |
| changelog-file-location | Relative location of changelog file from root of git repository. This is **required**                 |          |

### Outputs
You can use this to get the version number that has been or is to be created, and use it for other tools such as docker.
Below are examples of how to access the output and use it with other steps.

| Output        | Description                                         |
| ------------- | --------------------------------------------------- |
| version       | The version number that will be or has been created |

## Usage

### Validate
```
validate:
    runs-on: ubuntu-latest
    steps:
      - name: Release
        uses: sanjP10/release-action@1.0.0
        id: validate-release
        with:
          changelog-file-location: <Location of Changelog>
      - run: echo ${{ steps.validate-release.outputs.version }}
```

### Create
```
create:
    runs-on: ubuntu-latest
    steps:
      - name: Release
        uses: sanjP10/release-action@1.0.0
        id: create-release
        with:
          changelog-file-location: <Location of Changelog>
          operation: create
      - run: echo ${{ steps.create-release.outputs.version }}
```

# Notes

If you are intending on creating workflows that are based on the [release event](https://docs.github.com/en/actions/reference/events-that-trigger-workflows#release).
You need to use a token that is not the [github.token](https://docs.github.com/en/actions/reference/context-and-expression-syntax-for-github-actions#github-context) variable.
This needs to be a Personal Access Token that is associated to a user, which is also where the [github.actor](https://docs.github.com/en/actions/reference/context-and-expression-syntax-for-github-actions#github-context) may need to be static if your repository is shared across multiple users.
