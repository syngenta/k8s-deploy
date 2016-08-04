def print_git_check_branch(configuration)
  conf_branch = configuration['git_branch']
  local_branch = `git rev-parse --abbrev-ref HEAD`.strip
  check_result = local_branch == conf_branch

  puts 'Your local branch must be ' \
       "#{color_output(:green) { conf_branch }}:\t\t" \
       "#{check_result_output(check_result)}"
end

def print_git_check_uncommitted
  check_result = `git status --porcelain`.empty?

  puts "Your local branch must be clear:\t\t" \
       "#{check_result_output(check_result)}"
end

def print_git_check_remote_branch(configuration)
  conf_branch = configuration['git_branch']

  local_git_hash = `git rev-parse #{conf_branch}`
  remote_git_hash = `git rev-parse origin/#{conf_branch}`
  check_result = local_git_hash == remote_git_hash

  puts "Your local version must be same as GitHub:\t" \
       "#{check_result_output(check_result)}"
end

def print_gcloud_check_project(configuration)
  conf_gcloud_project = configuration['gcloud_project_name']
  current_gcloud_project = `gcloud config get-value project`
  check_result = current_gcloud_project.include?(conf_gcloud_project)

  puts 'Your GCloud project should be ' \
       "#{color_output(:green) { conf_gcloud_project }}:\t" \
       "#{check_result_output(check_result)}"
end

def print_gcloud_check_kubectl_context(configuration)
  conf_k8s_context = configuration['kubernetes_context']
  current_k8s_context = `kubectl config view -o jsonpath='{.current-context}'`
  check_result = current_k8s_context == conf_k8s_context

  puts 'Your K8s context should be ' \
       "#{color_output(:green) { conf_k8s_context }}:\t" \
       "#{check_result_output(check_result)}"
end
