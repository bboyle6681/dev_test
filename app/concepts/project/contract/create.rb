require "reform/form/dry"

module Project::Contract
  class Create < Reform::Form
    feature Reform::Form::Dry

    property :name
    property :tags
    property :Type

    validation :default do
      params do
        required(:name).filled(:string)
        required(:tags).filled(:string)
        optional(:Type).filled(included_in?: ['a', 'b', 'c'])
      end

      rule(:name) do
        key.failure('must be unique') unless Project.where(name: value).empty?
      end

      rule(:tags) do
        key.failure('invalid json') unless is_json? value
      end
      
      def is_json?(value)
        begin
          !!JSON.parse(value)
        rescue
          false
        end
      end
      
    end
  end
end
