CONFIGURATION_OPTIONS = {
  'git_branch' => 'GIT branch',
  'dockerfile' => 'Path to Dockerfile',
  'container_registry' => 'Docker container registry',
  'gcloud_project_name' => 'GCloud project name',
  'kubernetes_context' => 'K8s context',
  'kubernetes_deployment_name' => 'K8s deployment name',
  'kubernetes_template_name' => 'K8s deployment -> template name',
  'kubernetes_docker_image_name' => 'K8s deployment -> template -> docker image'
}.freeze

def validate_configuration(configuration)
  missed_parameters = CONFIGURATION_OPTIONS.keys - configuration.keys

  unless missed_parameters.empty?
    params_string = missed_parameters.join(', ')
    raise "Missed parameters in configuration: #{params_string}."
  end
end

def print_configuration(configuration)
  max_name_length = CONFIGURATION_OPTIONS.values.map(&:length).max
  CONFIGURATION_OPTIONS.each do |key, name|
    value = configuration.fetch(key, '—')
    puts "#{name.rjust(max_name_length)}: #{color_output(:green) { value }}"
  end
end
