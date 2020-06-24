require 'rails_helper'

describe Project do
  it 'persists the right fields' do
    tags_json = {key: 'value'}.to_json
    Project.create(name: 'project_name', tags: tags_json, Type: 'a')
    result = Project.where(name: 'project_name').first
    assert_equal 'project_name', result.name
    assert_equal tags_json, result.tags
    assert_equal 'a', result.Type
  end
end
