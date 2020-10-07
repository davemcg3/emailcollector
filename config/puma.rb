# workers Integer(ENV['WEB_CONCURRENCY'] || 2)
# threads_count = Integer(ENV['RAILS_MAX_THREADS'] || 5)
# threads threads_count, threads_count
#
# preload_app!
#
# rackup      DefaultRackup
# port        ENV['PORT']     || 3000
#
# app_dir = File.expand_path("../..", __FILE__)
# puts "app_dir #{app_dir}"
# shared_dir = "#{app_dir}"
#
# # Default to production
# rails_env = ENV['RAILS_ENV'] || "production"
# environment rails_env
#
# # Set up socket location
# bind "unix:/#{shared_dir}/sockets/puma.sock"
#
# # Logging
# stdout_redirect "#{shared_dir}/log/puma.stdout.log", "#{shared_dir}/log/puma.stderr.log", true
#
# # Set master PID and state locations
# pidfile "#{shared_dir}/pids/puma.pid"
# state_path "#{shared_dir}/pids/puma.state"
# activate_control_app
#
# on_worker_boot do
#   require "active_record"
#   ActiveRecord::Base.connection.disconnect! rescue ActiveRecord::ConnectionNotEstablished
#   ActiveRecord::Base.establish_connection(YAML.load_file("#{app_dir}/config/database.yml")[rails_env])
# end


# Place in /config/puma/production.rb

rails_env = "production"
environment rails_env

# app_dir = File.expand_path("../..", __FILE__)
app_dir = '/var/www/apps/ruby/emailcollector/current'

bind  "unix://#{app_dir}/puma.sock"
pidfile "#{app_dir}/puma.pid"
state_path "#{app_dir}/puma.state"
directory "#{app_dir}/"

stdout_redirect "#{app_dir}/log/puma.stdout.log", "#{app_dir}/log/puma.stderr.log", true

workers 2
threads 1,2

activate_control_app "unix://#{app_dir}/pumactl.sock"

prune_bundler
