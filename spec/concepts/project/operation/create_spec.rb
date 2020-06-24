require 'rails_helper'


describe Project::Create  do
  
  context 'with good data' do
    let(:params) { { project: { name: 'project_name', tags: {key: "value"}.to_json, Type: 'a' }} }

    it 'loads the correct data in the model' do
      result = Project::Create.(params: params)

      assert result.success?
      assert_equal "project_name", result["model"].name
      assert_equal(({key: "value"}.to_json), result["model"].tags)
      assert_equal 'a', result["model"].Type
    end
  end

  context 'with bad data' do
    let(:params) { { project: {}} }

    it 'fails with messages for the right keys' do
      result = Project::Create.(params: params)

      assert result.failure?
      assert_equal [:name, :tags, :Type], result["contract.default"].errors.messages.keys
    end
  end

end
