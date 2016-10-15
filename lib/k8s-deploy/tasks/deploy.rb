def build_timestamp
  CURRENT_TIME.strftime('%Y%m%d%H%M%S')
end

def build_tag_name(git_hash)
  build_timestamp + '-' + git_hash
end

def get_git_hash(configuration)
  conf_branch = configuration['git_branch']
  `git rev-parse #{conf_branch}`
end

def build_full_image_name(configuration)
  registry = configuration['container_registry']
  gcloud_project_name = configuration['gcloud_project_name']
  docker_image_name = configuration['kubernetes_docker_image_name']
  local_git_hash = get_git_hash(configuration)[0..6]
  tag = build_tag_name(local_git_hash)

  "#{registry}/#{gcloud_project_name}/#{docker_image_name}:#{tag}"
end

def print_deploy_build(configuration)
  conf_branch = configuration['git_branch']
  new_image_name = build_full_image_name(configuration)

  puts "New name:\t#{color_output(:green) { new_image_name }}"
  puts
  new_git_hash = get_git_hash(configuration)[0..6]
  puts "New GIT hash:\t#{color_output(:green) { new_git_hash }}"

  git_hash = `git rev-parse #{conf_branch}`
  git_info = `git log -1 --format=full #{git_hash}`

  puts
  puts "\t\t--- GIT commit info ---"
  git_info.each_line do |line|
    puts "\t\t#{line}"
  end
  puts "\t\t-----------------------"
  puts
  puts "New Timestamp:\t#{color_output(:green) { build_timestamp }}"
  puts

  dockerfile_path = configuration['dockerfile']
  command = "docker build -t #{new_image_name} -f #{dockerfile_path} ."
  command_output(command)
  puts

  system command
end

def print_deploy_push(configuration)
  new_image_name = build_full_image_name(configuration)
  command = "gcloud docker -- push #{new_image_name}"
  command_output(command)
  puts
  system command
  puts
  puts 'Sleeping for 5 seconds...'
  sleep 5
end

def print_deploy_deployment_patch(configuration)
  deployment_name = configuration['kubernetes_deployment_name']
  template_name = configuration['kubernetes_template_name']
  new_image_name = build_full_image_name(configuration)

  json_template = {
    spec: {
      template: {
        spec: {
          containers: [{
            name: template_name,
            image: new_image_name
          }]
        }
      }
    }
  }

  template_string = JSON.dump(json_template)

  command = "kubectl patch deployment #{deployment_name} -p " \
            "'#{template_string}' --record"

  command_output(command)
  puts

  print color_output(:yellow) { 'Confirm deploy (y/N): ' }

  case STDIN.gets.strip
  when 'Y', 'y', 'Yes', 'yes'
    puts
    puts color_output(:green) { 'Starting deploy...' }
    system command
    puts
    puts 'Now you can check deploy status with ' \
         "#{color_output(:yellow) { 'status' }} command."
  else
    puts
    puts color_output(:red) { 'Deploy terminated.' }
    exit 1
  end
end

def print_deploy_rollback(configuration)
  deployment_name = configuration['kubernetes_deployment_name']
  command = "kubectl rollout undo deployment #{deployment_name}"

  command_output(command)
  puts
  system command
end

def print_deploy_scale(configuration, replicas_count)
  deployment_name = configuration['kubernetes_deployment_name']
  command = "kubectl scale deployment #{deployment_name} " \
            "--replicas=#{replicas_count}"

  command_output(command)
  puts
  system command
end
