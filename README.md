# k8s-deploy — automate deployments to Google Kubernetes Engine

- [Introduction](#introduction)
- [Installation](#installation)
- [Configuration](#configuration)
- [Tasks](#tasks)
- [Contributing](#contributing)
- [License](#license)

## Introduction

This gem provides a bunch of useful **Rake** tasks to automate deployment to the Kubernetes cluster in Google Kubernetes Engine (GKE):

- Show configuration for the environment.
- Show the status of running Deployment & Pods.
- Check GCloud/K8s configuration and GIT (branch, uncommitted changes, etc.).
- Build a new Docker image, push it to the registry, and patch Deployment.
- Rollback Deployment to the previous state.
- Scale Deployment to the desired number of replicas.

## Installation

### Bundler

Add the gem to your Gemfile:

```ruby
gem 'k8s-deploy'
```

### Manual

Invoke the following command from your terminal:

```shell
gem install k8s-deploy
```

## Configuration

1. Put the `k8s-deploy.yml` configuration file into your project root.
2. Add `require 'k8s-deploy/tasks'` line to your Rakefile.
3. Check available tasks with `rake -T` command.

### Example of k8s-deploy.yml

```yml
production: # environment name
  git_branch: master
  dockerfile: ./Dockerfile
  docker_platform: linux/amd64
  container_registry: gcr.io
  gcloud_project_name: your-gcloud-project-name
  kubernetes_context: your-cluster-context
  kubernetes_deployment_name: your-deployment-name
  kubernetes_template_name: your-template-name
  kubernetes_docker_image_name: your-dcoker-image-name
```

You could add as many environments as you need (production, staging, test, etc.) to `k8s-deploy.yml`.

### Example of Rakefile file

```ruby
require 'k8s-deploy/tasks'
```

### Example of `rake -T` output

```shell
rake k8s:production:check                         # Check production ready for deploy
rake k8s:production:check:gcloud                  # Check production GCloud
rake k8s:production:check:git                     # Check production GIT
rake k8s:production:configuration                 # Show production configuration
rake k8s:production:deploy                        # Deploy to production
rake k8s:production:deploy:build                  # Build container for production
rake k8s:production:deploy:deployment_patch       # Deployment patch for production
rake k8s:production:deploy:push                   # Push container for production
rake k8s:production:deploy:rollback               # Rollback last deployment to production
rake k8s:production:deploy:scale[replicas_count]  # Scale deployment production
rake k8s:production:status                        # Show production K8s status
rake k8s:production:status:deployment             # Show production K8s Deployment status
rake k8s:production:status:docker_image           # Show production K8s Deployment status
rake k8s:production:status:pods                   # Show production K8s Pods status
```

## Tasks

All tasks have next structure:

```shell
rake k8s:<environment>:<main-task>:<sub-task>
```

### Main tasks

Show configuration for the environment:

```shell
rake k8s:<environment>:configuration
```

Show the status of running Deployment & Pods:

```shell
rake k8s:<environment>:status
```

Check GCloud/K8s configuration and GIT (branch, uncommitted changes, etc.):

```shell
rake k8s:<environment>:check
```

Build a new Docker image, push it to the registry, and patch Deployment:

```shell
rake k8s:<environment>:deploy
```

Rollback Deployment to the previous state.

```shell
rake k8s:<environment>:rollback
```

Scale Deployment to the desired number of replicas.

```shell
rake k8s:<environment>:scale[1]
```

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/cropio/k8s-deploy](https://github.com/cropio/k8s-deploy).

Please, check our [Contribution guide](CONTRIBUTING.md) for more details.

This project adheres to the [Code of Conduct](CODE_OF_CONDUCT.md). We pledge to act and interact in ways that contribute to an open, welcoming, diverse, inclusive, and healthy community.

## License

The project uses the MIT License. See LICENSE for details.
