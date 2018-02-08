require('rspec')
require('project_creator')

describe('#Project') do
  it("create new project") do
    project = Project.new()
    project.create
  end
end
