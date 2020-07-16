require_relative 'config/environment'
require 'sinatra/activerecord/rake'

desc 'starts a console'
task :console do
  # ActiveRecord::Base.logger = nil
  Pry.start
end

desc 'starts app'
task :start do
  # ActiveRecord::Base.logger = nil
  system 'ruby bin/run.rb'
end