class Api < Grape::API
  version 'v1', using: :path
  format :json
  prefix :api

  resource :project do
    desc 'Create Project'
    post do 
      result = Project::Create.(params: params)
      if result.success?
        status 201
      else
        error!({error_message: result["contract.default"].errors.full_messages}, 400)
      end
    end

    desc 'returns all projects paginated'
    get do
      Project::Index.(params: params)['model']
    end
  end
end
