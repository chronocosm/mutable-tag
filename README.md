# mutable-tag

A GitHub Action to create a Git tag in the format `vM` from the
[Semantically Versioned] GitHub release tag.

## Overview

Using the Semantic Version of a GitHub release, update the "vX" Git tag.

## Use

1. If accessing a private repository,
   use a [Personal Access Token] to create a [GitHub Secret] (e.g. XXXX_ACCESS_TOKEN).
1. To use, create a `.github/workflows/version-tag.yaml` file with the following contents:

    ```yaml
    name: mutable-tag.yaml

    on:
      push:
        tags:
          - "[0-9]+.[0-9]+.[0-9]+"

    permissions:
      contents: write

    jobs:
      build:
        name: Make a mutable tag
        runs-on: ubuntu-latest
        steps:
          - name: Checkout repository
            uses: actions/checkout@v4
          - name: Make mutable tag
            env:
              GITHUB_AUTHENTICATION_TOKEN: ${{ secrets.XXXX_ACCESS_TOKEN }}
            uses: chronocosm/mutable-tag@v1
    ```

[GitHub Secret]: https://docs.github.com/en/actions/security-guides/using-secrets-in-github-actions
[Personal Access Token]: https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens
[Semantically Versioned]: (https://semver.org/)
