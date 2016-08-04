require 'rake'

module K8sDeploy
  class Tasks
    include Rake::DSL if defined? Rake::DSL
    def install_tasks
      load 'k8s-deploy/tasks/k8s-deploy.rake'
    end
  end
end

K8sDeploy::Tasks.new.install_tasks
