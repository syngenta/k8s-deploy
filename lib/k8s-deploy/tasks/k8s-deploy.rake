require 'yaml'
require 'json'
require 'time'

require_relative 'console_formatters.rb'
require_relative 'configuration.rb'
require_relative 'status.rb'
require_relative 'check.rb'
require_relative 'deploy.rb'

# Configuration file path
CONFIGURATION_FILE = 'k8s-deploy.yml'.freeze

# Get start time
CURRENT_TIME = Time.now.utc

# Read configuration file
begin
  CONFIGURATION = YAML.load_file(CONFIGURATION_FILE)
rescue Errno::ENOENT
  CONFIGURATION = [].freeze
end

namespace :k8s do
  CONFIGURATION.each do |environment, configuration|
    validate_configuration(configuration)

    namespace environment do
      desc "Show #{environment} configuration"
      task :configuration do
        block_output("Configuration for #{environment}") do
          print_configuration(configuration)
        end
      end

      desc "Show #{environment} K8s status"
      task status: ['status:deployment', 'status:pods', 'status:docker_image']

      namespace :status do
        desc "Show #{environment} K8s Pods status"
        task :pods do
          block_output("K8s Pods status for #{environment}") do
            print_pods_status(configuration)
          end
        end

        desc "Show #{environment} K8s Deployment status"
        task :deployment do
          block_output("K8s Deployment status for #{environment}") do
            print_deployment_status(configuration)
          end
        end

        desc "Show #{environment} K8s Deployment status"
        task :docker_image do
          block_output("K8s Docker image status for #{environment}") do
            print_docker_image_status(configuration)
          end
        end
      end

      desc "Check #{environment} ready for deploy"
      task check: ['check:git', 'check:gcloud']

      namespace :check do
        desc "Check #{environment} GIT"
        task :git do
          block_output("Check GIT for #{environment}") do
            print_git_check_branch(configuration)
            print_git_check_uncommitted
            print_git_check_remote_branch(configuration)
          end
        end

        desc "Check #{environment} GCloud"
        task :gcloud do
          block_output("Check GCloud for #{environment}") do
            print_gcloud_check_project(configuration)
            print_gcloud_check_kubectl_context(configuration)
          end
        end
      end

      desc "Deploy to #{environment}"
      task deploy: [:configuration, :check, :status,
                    'deploy:build',
                    'deploy:push',
                    'deploy:deployment_patch']

      namespace :deploy do
        desc "Build container for #{environment}"
        task :build do
          block_output("Build container for #{environment}") do
            print_deploy_build(configuration)
          end
        end

        desc "Push container for #{environment}"
        task :push do
          block_output("Push container for #{environment}") do
            print_deploy_push(configuration)
          end
        end

        desc "Deployment patch for #{environment}"
        task :deployment_patch do
          block_output("Deployment patch for #{environment}") do
            print_deploy_deployment_patch(configuration)
          end
        end

        desc "Rollback last deployment to #{environment}"
        task :rollback do
          block_output("Rollback for #{environment}") do
            print_deploy_rollback(configuration)
          end
        end

        desc "Scale deployment #{environment}"
        task :scale, [:replicas_count] do |_task, args|
          block_output("Scale for #{environment}") do
            print_deploy_scale(configuration, args[:replicas_count])
          end
        end
      end
    end
  end
end
