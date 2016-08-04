K8s deploy
=============

Introduction
------------

:bomb: **Important — this gem is not production ready.**

This gem provides bunch of useful **Rake** tasks to automate deploy to Kubernetes cluster in Google Container Engine.

Installation
------------

### Bundler

Add gem to your Gemfile:

```ruby
gem 'k8s-deploy'
```

### Manual

Invoke the following command from your terminal:

```bash
gem install k8s-deploy
```

Configuration
-------------

1. You need to put `k8s-deploy.yml` file into your project root.
2. Add `require 'k8s-deploy/tasks'` to your Rakefile.
3. Check available tasks with `rake -T` command.

##### Example of k8s-deploy.yml

```yml
production: # environment name
  git_branch: master
  dockerfile: ./Dockerfile
  container_registry: gcr.io
  gcloud_project_name: your-gcloud-project-name
  kubernetes_context: your-cluster-context
  kubernetes_deployment_name: your-deployment-name
  kubernetes_template_name: your-template-name
  kubernetes_docker_image_name: your-dcoker-image-name
```

You could add as many environments as you need (production, staging, test, etc.) to `k8s-deploy.yml`.

##### Example of Rakefile

```ruby
require 'k8s-deploy/tasks'
```

##### Example of `rake -T` output

```bash
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

Tasks
-------------

All tasks have next structure:

```bash
rake k8s:<environment>:<main-task>:<sub-task>
```

### Main tasks

Show configuration for environment:
```bash
rake k8s:<environment>:configuration
```

Show status of running Deployment & Pods:
```bash
rake k8s:<environment>:status
```

Check GCloud/K8s configuration and GIT (branch, uncommitted changes, etc.):
```bash
rake k8s:<environment>:check
```

Build new Docker image, push to registry, patch Deployment:
```bash
rake k8s:<environment>:deploy
```

Rollback Deployment to previous state.
```bash
rake k8s:<environment>:rollback
```

Scale Deployment to desired number of replicas.
```bash
rake k8s:<environment>:scale[1]
```

License
-------

The project uses the MIT License. See LICENSE.md for details.
