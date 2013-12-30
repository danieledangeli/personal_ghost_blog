set :application, 'blog.danieledangeli'
set :repo_url, 'git@github.com:danieledangeli/personal_ghost_blog.git'
set :user, "root"
set :domain, ["37.139.23.206"]
set :deploy_to, '/home/blog.danieledangeli'
set :scm,         :git
set :branch, "master"


namespace :deploy do

   desc "Start forever"
   task :start_forever do
     on roles(:app) do
       execute "cd #{current_path} && sudo forever start index.js"
     end
   end

   desc "Symlink data"
   task :symlink do
     on roles(:app), in: :sequence, wait: 2 do
       execute "ln -s #{shared_path}/data #{release_path}/content/data"
       execute "ln -s #{shared_path}/images #{release_path}/content/images"
       execute "ln -s #{shared_path}/plugins #{release_path}/content/plugins"
       execute "cd #{current_path} && forever start index.js"
     end
   end


  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do

    end
  end


  after :deploy, 'deploy:symlink', 'start_forever'
  after :finishing, 'deploy:cleanup'

end

