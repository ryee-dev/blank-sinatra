require('rspec')
require('sinatra_template_script')

describe('#Project') do
  it("create new project") do
    project = Project.new()
    project.create
  end
end
