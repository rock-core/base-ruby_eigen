# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new("test:lib") do |t|
    t.libs << "test"
    t.libs << "lib"
    t.test_files = FileList["test/**/*_test.rb"]
end

task "rubocop" do
    raise "rubocop failed" unless system(ENV["RUBOCOP_CMD"] || "rubocop")
end
desc "Run tests"
task "test" => "test:lib"
task "test" => "rubocop"

require "rake/extensiontask"

task build: :compile

Rake::ExtensionTask.new("eigen") do |ext|
    ext.lib_dir = "lib/eigen"
end

task default: :compile
