# frozen_string_literal: true

def print_deployment_status(configuration)
  deployment_name = configuration['kubernetes_deployment_name']

  basic_info_command = "kubectl get deployment #{deployment_name} --show-labels"
  command_output(basic_info_command)
  puts
  system basic_info_command
  puts

  describe_command = "kubectl describe deployment #{deployment_name}"
  command_output(describe_command)
  puts
  system describe_command
end

def print_pods_status(configuration)
  template_name = configuration['kubernetes_template_name']

  command = "kubectl get pods --show-labels -l name=#{template_name}"
  command_output(command)
  puts
  system command
end

def print_docker_image_status(configuration)
  deployment_name = configuration['kubernetes_deployment_name']

  command = "kubectl get deployment #{deployment_name} -o template " \
            "'--template={{(index .spec.template.spec.containers 0).image}}'"

  command_output(command)
  puts

  docker_image = `#{command}`
  puts "Full name:\t#{color_output(:green) { docker_image }}"

  time_hash = docker_image.split(':').last
  git_hash = time_hash.split('-').last
  timestamp = time_hash.split('-').first

  puts

  # check git_hash is valid
  if git_hash && /^[a-f0-9]+$/.match(git_hash)
    puts "GIT hash:\t#{color_output(:green) { git_hash }}"
    git_info = `git log -1 --format=full #{git_hash}`

    puts
    puts "\t\t--- GIT commit info ---"
    git_info.each_line do |line|
      puts "\t\t#{line}"
    end
    puts "\t\t-----------------------"
  else
    puts color_output(:red) { "ERROR! Can't parse GIT hash from tag!" }
  end

  puts
  begin
    time_utc = Time.strptime("#{timestamp} UTC", '%Y%m%d%H%M%S %Z')
    puts "Timestamp:\t#{color_output(:green) { timestamp }}"
    puts "Time (UTC):\t#{time_utc}"
    puts "Time (local):\t#{time_utc.getlocal}"
  rescue ArgumentError
    puts color_output(:red) { "ERROR! Can't parse timestamp from tag!" }
  end
end
