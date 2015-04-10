namespace :deploy do

  desc "Makes sure local git is in sync with remote."
  task :check_revision do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end

  %w[start stop restart].each do |command|
    desc "#{command} Unicorn server."
    task command do
      on roles(:app) do
        execute "sudo service unicorn #{command}"
      end
    end
  end

  desc "Restart Nginx server."
    task :nginx_restart do
      on roles(:app) do
        execute "sudo service nginx restart"
      end
    end

  before :deploy, "deploy:check_revision"
  after :deploy, "deploy:restart"
  after :deploy, "deploy:nginx_restart"
  after :rollback, "deploy:restart"    
  after :rollback, "deploy:nginx_restart"
end