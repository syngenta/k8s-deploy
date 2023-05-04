# Contributing

- [Introduction](#introduction)
- [Reporting issues](#reporting-issues)
- [Contributing to code](#contributing-to-code)
  - [Workflow for local development](#workflow-for-local-development)
  - [Workflow for GitHub Codespaces in-browser development](#workflow-for-github-codespaces-in-browser-development)
  - [About using VSCode](#about-using-vscode)

## Introduction

Contribution is welcome!

This project adheres to the [Code of Conduct](CODE_OF_CONDUCT.md). We pledge to act and interact in ways that contribute to an open, welcoming, diverse, inclusive, and healthy community.

## Reporting issues

Please, report any issues or bugs you find in the project's [Issues](https://github.com/cropio/k8s-deploy/issues) section on GitHub.

## Contributing to code

### Workflow for local development

1. [Fork the repo](https://docs.github.com/en/get-started/quickstart/fork-a-repo#forking-a-repository).
2. [Clone the forked repo](https://docs.github.com/en/get-started/quickstart/fork-a-repo#cloning-your-forked-repository) to your local machine.
3. Create a new branch for your changes:
  `git checkout -b "feat/my-new-feature"`.
4. Make your changes. We recommend using [VSCode + Docker](#about-using-vscode) locally.
5. Commit your changes:
  `git commit -m "feat: my new feature"`.
6. Push your changes to your forked repo:
  `git push origin feat/my-new-feature`.
7. [Create a pull request](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request-from-a-fork) from your forked repo to the main repo.

### Workflow for GitHub Codespaces in-browser development

1. [Fork the repo](https://docs.github.com/en/get-started/quickstart/fork-a-repo#forking-a-repository).
2. Open Codespaces by clicking the green button **Code** on the top right corner of the repo and then **Open with Codespaces**.
GitHub Codespaces will create and open a full-featured dev environment in the browser. You don't need to install anything locally.
3. Create a new branch for your changes:
  `git checkout -b "feat/my-new-feature"`
4. Make your changes.
5. Commit your changes:
  `git commit -m "feat: my new feature"`
6. Push your changes to your forked repo:
  `git push origin feat/my-new-feature`
7. [Create a pull request](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request-from-a-fork) from your forked repo to the main repo.

### About using VSCode

The recommended way for local development is to use VSCode + Docker Desktop.

- [VSCode](https://code.visualstudio.com/)
- [Docker Desktop](https://www.docker.com/)

VSCode supports `.devcontainer` configuration that will automatically build a full-featured dev environment for you. All plugins and hooks are already configured for you.

```shell
git clone git@github.com:cropio/k8s-deploy.git
cd k8s-deploy

code .
```
