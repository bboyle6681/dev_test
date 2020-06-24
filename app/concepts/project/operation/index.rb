class Project::Index < Trailblazer::Operation
  step :model!
  step Contract::Build( constant: Project::Contract::Index )
  step Contract::Validate()
  step :paginate

  def model!(options, *)
    options['model'] = Paginator.new({}, Project)
  end

  def paginate(ctx, *)
    # There is Obviously a better way to do this but I havent found it yet.
    
    result = ctx['contract.default'].to_result.to_results.first
    model = ctx['model']
    model.per= result[:per]
    model.page= result[:page]
    model.sort_attr = result[:sort_attr].to_sym
    model.order = result[:order].to_sym
    
    ctx['model'] = model.paginate
  end
end
