#!/usr/bin/ruby
require 'fileutils'

class Project
  def initialize(project_name)
    @project_name = project_name
  end

  def create
    FileUtils.cd ".."
    puts FileUtils.pwd()
    FileUtils.mkdir(@project_name)
    FileUtils.cd "#{@project_name}"
    FileUtils.mkdir("lib")
    FileUtils.mkdir("spec")
    FileUtils.touch("Gemfile")
    File.open("Gemfile", 'w') { |file| file.write("source 'https://rubygems.org' \n gem 'rspec' \n gem 'pry'") }
    system "bundle install"
    FileUtils.touch("lib/#{@project_name}.rb")
    FileUtils.touch("spec/#{@project_name}_spec.rb")

  end
end

puts "Enter a desired project name"
project_name = gets.chomp
puts "Enter a number of classes you want"
num_of_classes = gets.chomp
project = Project.new(project_name)
project.create
