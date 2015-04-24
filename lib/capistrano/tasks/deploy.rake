namespace :deploy do

  desc "Makes sure local git is in sync with remote."
  task :check_revision do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end

  desc "Kill the unicorn server"
  task :unicorn_kill do
    on roles(:app) do
      unicorn_pid = capture(:cat, '/home/ubuntu/tedtkang/tmp/pids/unicorn.pid') rescue nil
      execute :kill, unicorn_pid
    end
  end

  desc "Start the unicorn server"
  task :unicorn_start do
    on roles(:app) do
      execute "sudo service unicorn start"
    end
  end


  desc "Restart Nginx server."
  task :nginx_restart do
    on roles(:app) do
      execute "sudo service nginx restart"
    end
  end

  before :deploy, "deploy:check_revision"
  after :deploy, "deploy:unicorn_kill"
  # The DB migration and asset compliation happen automatically
  # because we included them in the Capfile.
  # after :deploy, "deploy:migrate"
  # after :deploy, "deploy:compile_assets"
  after :deploy, "deploy:unicorn_start"
  after :deploy, "deploy:nginx_restart"
  after :rollback, "deploy:unicorn_kill"
  after :rollback, "deploy:unicorn_start"
  after :rollback, "deploy:nginx_restart"
end