# encoding: UTF-8
require "English"

## Style checking
#
namespace :style do
  begin
    require "rubocop/rake_task"
    desc "Run Ruby style checks"
    RuboCop::RakeTask.new(:ruby)
  rescue LoadError
    "#{$ERROR_INFO} -- rubocop tasks not loaded!"
  end
end

desc "Run all style checks"
task :style => %w{ style:ruby }
