require 'mina/multistage'
require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rvm'
require 'mina/whenever'
require 'mina/appsignal'

set :term_mode, nil

set :rvm_path, '/home/deploy/.rvm/scripts/rvm'

# Manually create these paths in shared/ (eg: shared/config/database.yml) in your server.
# They will be linked in the 'deploy:link_shared_paths' step.
set :shared_paths, %w(config/application.yml config/database.yml config/secrets.yml log config/unicorn.rb public/uploads unicorn_shared)

set :domain, 'mark-1.snappler.com'
set :user, 'deploy'
set :repository, 'git@gitlab.snappler.com:snappler/jobbier.git'
set :unicorn_file, "unicorn_jobbier_#{rails_env}.service"
set :whenever_name, "jobbier_#{rails_env}"

set :appsignal_api_key, '6fd70522-cf88-4a9e-8e71-804a1d07282a'
set :appsignal_app_name, 'Jobbier'

# Optional settings:

#   set :port, '30000'     # SSH port number.
#   set :forward_agent, true     # SSH forward_agent.

# This task is the environment that is loaded for most commands, such as
# `mina deploy` or `mina rake`.
task :environment do
  invoke :'rvm:use[ruby-2.3.0@jobbier]'
end


# Put any custom mkdir's in here for when `mina setup` is ran.
# For Rails apps, we'll make some of the shared paths that are shared between
# all releases.
task setup: :environment do
  queue! %[mkdir -p "#{deploy_to}/shared/public/uploads"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/public/uploads"]

  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/log"]
  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/unicorn_shared"]
  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/unicorn_shared/pids"]
  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/unicorn_shared/sockets"]
  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/unicorn_shared/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/unicorn_shared"]

  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/config"]

  queue! %[touch "#{deploy_to}/#{shared_path}/config/application.yml"]
  queue! %[touch "#{deploy_to}/#{shared_path}/config/database.yml"]
  queue! %[touch "#{deploy_to}/#{shared_path}/config/secrets.yml"]
  queue! %[touch "#{deploy_to}/#{shared_path}/config/unicorn.rb"]
  queue  %[echo "-----> Be sure to edit '#{deploy_to}/#{shared_path}/config/database.yml', 'secrets.yml' and 'unicorn.rb'"]

  # queue %[
  #   repo_host=`echo $repo | sed -e 's/.*@//g' -e 's/:.*//g'` &&
  #   repo_port=`echo $repo | grep -o ':[0-9]*' | sed -e 's/://g'` &&
  #   if [ -z "${repo_port}" ]; then repo_port=22; fi &&
  #   ssh-keyscan -p $repo_port -H $repo_host >> ~/.ssh/known_hosts
  # ]
end


desc 'Deploys the current version to the server.'
task deploy: :environment do
  to :before_hook do
    # Put things to run locally before ssh
  end

  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_create' #Esta linea se puede remover despues del primer deploy exitoso
    invoke :'rails:db_migrate:force'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    to :launch do
      queue! 'echo "-----> Unicorn Restart"'
      invoke :'unicorn:restart'
      invoke :'whenever:update' if rails_env == 'production'
      invoke :'appsignal:notify'
    end
  end
end


namespace :nginx do
  desc 'Reiniciar el servidor nginx'
  task :restart do
    queue 'sudo service nginx restart'
  end
end


namespace :unicorn do
  desc 'Iniciar la applicaion unicorn - con environment'
  task :start do
    queue "sudo systemctl start #{unicorn_file}"
  end

  desc 'Frena la applicaion unicorn - con environment'
  task :stop do
    queue "sudo systemctl stop #{unicorn_file}"
  end

  desc 'Reinicia la applicaion unicorn - con environment'
  task :restart do
    queue "sudo systemctl restart #{unicorn_file}"
  end
end


namespace :figaro do
  # desc 'Envia el archivo config/application.yml al servidor'
  # task :upload do
  #   %x[scp config/application.yml #{user}@#{domain}:#{dump_file}.gz .]
  # end

  desc 'Muestra el contenido del archivo config/application.yml en el servidor'
  task :show do
    queue "cat #{deploy_to}/#{shared_path}/config/application.yml"
  end
end


namespace :log do
  desc 'Muestra logs del servidor'
  task :server do
    queue "tail -f #{deploy_to}/#{shared_path}/log/nginx.* #{deploy_to}/#{shared_path}/unicorn_shared/log/unicorn.stderr.log"
  end

  desc 'Muestra logs de la aplicacion'
  task :app do
    queue "tail -f #{deploy_to}/#{shared_path}/log/#{rails_env}.log"
  end
end


namespace :db do
  desc 'DB production to staging'
  task :prod_to_staging do

    prod_db = 'jobbier_production'
    staging_db = 'jobbier_staging'
    mysql_usr = 'root'
    mysql_pwd = 'mysql.pass'


    queue "export MYSQL_PWD=#{mysql_pwd}"
    mysql_parameters = " -u #{mysql_usr} "

    mysql_command = "mysql #{mysql_parameters} "
    mysql_exec_command = "mysql #{mysql_parameters} -s -N -e "
    mysqldump_command = "mysqldump #{mysql_parameters} "

    puts "Dump de la base #{prod_db}"
    queue "#{mysqldump_command} #{prod_db} > /tmp/#{prod_db}.sql"

    puts "Borrando base: #{staging_db}"
    base = capture %Q[#{mysql_exec_command} "show databases like '#{staging_db}';"]
    if base.each_line.count == 1
      queue %Q[#{mysql_exec_command} "drop database #{staging_db};"]
    end
    puts "Creando base: #{staging_db}"
    queue %Q[#{mysql_exec_command} "create database #{staging_db};"]

    puts "Load de #{staging_db}"
    queue "#{mysql_command} #{staging_db} < /tmp/#{prod_db}.sql"
    queue "rm /tmp/#{prod_db}.sql"
  end

  task :clone do
    database = "jobbier_#{rails_env}"
    dump_file = "/tmp/#{database}.sql"

    # DUMP EN EL SERVIDOR
    isolate do
      queue 'export MYSQL_PWD=dumper.pass'
      queue "mysqldump -u dumper #{database} > #{dump_file}"
      queue "gzip -f #{dump_file}"

      mina_cleanup!
    end

    # LOCAL
    %x[scp #{user}@#{domain}:#{dump_file}.gz .]
    %x[gunzip -f #{database}.sql.gz]

    %x[RAILS_ENV=development bundle exec rake db:drop db:create]
    %x[mysql -u root -p jobbier_development < #{database}.sql]
    %x[rm #{database}.sql]
  end

end


namespace :assets do
  task :clone do
    %x[mkdir -p public/uploads]
    %x[rsync -azP --delete #{user}@#{domain}:#{deploy_to}/#{shared_path}/public/uploads/ public/uploads]
  end
end