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
      FileUtils.mkdir("views")
      FileUtils.mkdir("spec")
      FileUtils.mkdir("public")
        FileUtils.cd "public"
        FileUtils.mkdir("css")
        FileUtils.touch("../css/styles.css")
        FileUtils.mkdir("js")
        FileUtils.touch("../js/scripts.js")
        FileUtils.mkdir("img")
      FileUtils.cd ".."
      FileUtils.touch("Gemfile")
        File.open("Gemfile", 'w') { |file| file.write(
          "source 'https://rubygems.org'\n\ngem 'sinatra'\ngem 'rspec'\ngem 'pry'\ngem 'sinatra-contrib'")}
        system "bundle install"
      FileUtils.touch("app.rb")
        File.open("app.rb", 'w') { |file| file.write(
          "require('sinatra')\nrequire('sinatra/reloader')\nalso_reload('lib/**.*.rb')\nrequire('pry')\n\nget('/') do\n  erb(:input)\nend\n\nget('/output') do\n  erb(:output)\nend")}
      FileUtils.touch("lib/#{@project_name}.rb")
      FileUtils.touch("spec/#{@project_name}_spec.rb")
      FileUtils.touch("spec/#{@project_name}_integration_spec.rb")
        FileUtils.cd "views"
          FileUtils.touch("layout.erb")
          FileUtils.touch("input.erb")
          FileUtils.touch("output.erb")
          FileUtils.touch("home.erb")
            File.open("layout.erb", 'w') {|file| file.write(
              "<!DOCTYPE html>\n<html>\n  <head>\n    <link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css'>\n    <link rel='stylesheet' href='../css/styles.css'>\n    <script type='text/javascript' src='js/scripts.js'></script>\n    <script type='text/javascript' src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.js'></script>\n    <title>Insert Title</title>\n  </head>\n  <body> \n    <div class='container'>\n      <%= yield %>\n    </div>\n  </body> \n</html>")}

      FileUtils.cd ".."
    file_contents = "#!/usr/bin/ruby\n\n"

    @classes.each do |each_class|
      each_class = each_class.capitalize
      file_contents = file_contents.concat("class #{each_class}\n\nend\n\n")
    end

    File.open("lib/#{@project_name}.rb", 'w') { |file| file.write(file_contents) }
    File.open("spec/#{@project_name}_spec.rb", 'w') { |file| file.write("require\('rspec')\nrequire('#{@project_name}'\)\nrequire('pry')\n\ndescribe('#{@project_name}'\) do\n  it(\"create new project\") do\n  expect().to(eq())\n   end\nend") }
  end
end

puts "Enter project name: "
project_name = gets.chomp
puts "Enter class names for primary .rb file"
classes = gets.chomp
classes = classes.split(" ")
project = Project.new(project_name, classes)
project.create
