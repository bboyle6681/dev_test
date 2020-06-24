require 'rails_helper'

describe 'POST /api/v1/project'  do
  context 'with valid parameters' do
    let(:params) { { project: { name: 'project_name', tags: {key: "value"}.to_json, Type: 'a' }} }
    it 'returns 201' do
      post '/api/v1/project', params: params
      expect(response.status).to eq(201)
    end

    it 'persists the project model' do
      post '/api/v1/project', params: params
      expect(Project.where(name: params[:project][:name])).to exist
    end
  end

  context 'with no name' do
    let(:params) { { project: { name: nil, tags: {key: "value"}.to_json, Type: 'a' }} }
    it 'returns 400' do
      post '/api/v1/project', params: params
      expect(response.status).to eq(400)
    end
  end

  context 'with invalid tags json' do
    let(:params) { { project: { name: 'project_name', tags: 'not_json', Type: 'a' }} }
    it 'returns 400' do
      post '/api/v1/project', params: params
      expect(response.status).to eq(400)
    end
  end

  context 'with bad Type' do
    let(:params) { { project: { name: 'project_name', tags: {key: "value"}.to_json, Type: 'z' }} }
    it 'returns 400' do
      post '/api/v1/project', params: params
      expect(response.status).to eq(400)
    end
  end

  context 'with non-unique name' do
    let(:params) { { project: { name: 'project_name', tags: {key: "value"}.to_json, Type: 'a' }} }
    it 'returns 400' do
      post '/api/v1/project', params: params
      post '/api/v1/project', params: params
      expect(response.status).to eq(400)
    end
  end
end

describe 'GET /api/v1/project' do
  let(:tags_json) { {key: "value"}.to_json }
  it 'returns properly sorted page of projects' do
    Project::Create.(params: { project: { name: 'name1', tags: tags_json, Type: 'c'}})
    Project::Create.(params: { project: { name: 'name2', tags: tags_json, Type: 'a'}})

    get '/api/v1/project', params: { per: 1, page: 0, sort_attr: :Type, order: :asc }
    expect(JSON.parse(response.body).first['name']).to eq("name2")
  end
end
