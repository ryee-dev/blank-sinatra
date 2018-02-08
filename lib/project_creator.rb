#!/usr/bin/ruby
require 'fileutils'

class Project
  def initialize(project_name, classes)
    @project_name = project_name
    @classes = classes
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
    file_contents = "#!/usr/bin/ruby\n\n"
    @classes.each do |each_class|
      each_class = each_class.capitalize
      file_contents = file_contents.concat("class #{each_class}\n\nend\n\n")
    end
    File.open("lib/#{@project_name}.rb", 'w') { |file| file.write(file_contents) }
    File.open("spec/#{@project_name}_spec.rb", 'w') { |file| file.write("require\('rspec')\nrequire('#{@project_name}'\)\nrequire('pry')\n\ndescribe('#{@project_name}'\) do\n  it(\"create new project\") do\n\n  end\nend") }
  end
end

puts "Enter a desired project name"
project_name = gets.chomp
puts "Enter classes for your .rb file separating them by a space"
classes = gets.chomp
classes = classes.split(" ")
project = Project.new(project_name, classes)
project.create
