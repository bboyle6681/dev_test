require "reform/form/dry"
module Project::Contract
  class Index < Reform::Form
    feature Reform::Form::Dry

    property :per
    property :page
    property :sort_attr
    property :order

    validation :default do
      params do
        required(:per).filled(:integer)
        required(:page).filled(:integer)
        optional(:sort_attr).filled(:string)
        required(:order).filled(included_in?: ['asc', 'desc'])
      end
    end
  end
end
