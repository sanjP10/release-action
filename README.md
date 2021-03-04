# release-action

![Tests](https://github.com/sanjP10/release-action/workflows/Tests/badge.svg?branch=master)

This is an action that enables the use of the tool [release](https://github.com/sanjP10/release) in a github action.
This exposes the use of the tool with a github action interface.

Release is a tool that validates and creates tags against git repos by reading your changelog file.

It requires a markdown formatted changelog, with the most recent changes at the top.

The that consists of a version must start with a `h2` markup and have a number afterwards.

An example changelog would be

```
# Changelog

[//]: <> (Spaces an no spaces on version number lines are for checking regex in unit tests)
## 1.1.0

### Updated
* An update happened

## 1.0.0

### Added

* Initial release

```

the version numbers can be of a format with decimals separating them.

Example formats tha can be used are

```
major
major.minor
major.minor.patch
major.minor.patch.micro
```

## Variables

### Inputs

| Input                   | Description                                                                                           | Default  |
| ----------------------- |-------------------------------------------------------------------------------------------------------| --------|
| operation               | This defines what operation you would like to run via the release tool. Either `validate` or `create` | validate |
| user                    | User to use when validating/creating the release                                                      | [github.actor](https://docs.github.com/en/actions/reference/context-and-expression-syntax-for-github-actions#github-context) |
| token                   | Personal Access Token to use when validating/creating                                                 | [github.token](https://docs.github.com/en/actions/reference/context-and-expression-syntax-for-github-actions#github-context) |
| changelog-file-location | Relative location of changelog file from root of git repository. This is **required**                 |          |
| host                    | If using self-hosted github, this needs to be where you provide the full base url                     |          |

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
This needs to be a Personal Access Token(PAT) that is associated to a user, which is also where [github.actor](https://docs.github.com/en/actions/reference/context-and-expression-syntax-for-github-actions#github-context) is used by default as the user may need to be charged to a static user associated with the PAT if the repository is shared across multiple users.
