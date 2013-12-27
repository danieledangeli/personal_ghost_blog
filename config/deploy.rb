set :application, 'blog.danieledangeli'
set :repo_url, 'git@github.com:danieledangeli/personal_ghost_blog.git'
set :user, "root"
set :domain, ["37.139.23.206"]
set :deploy_to, '/home/blog.danieledangeli'
set :scm,         :git
set :branch, "master"

namespace :deploy do

  desc "Stop Forever"
   task :stop do
     run "sudo forever stopall"
   end

   desc "Start Forever"
     task :start do
        run "cd #{current_path} && sudo forever start index.js"
     end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do

    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after :finishing, 'deploy:cleanup'

end
