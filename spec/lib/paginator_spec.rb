require 'rails_helper'

describe Paginator do
  let(:tags_json) { { key: "value" }.to_json }

  before do
    Project::Create.(params: { project: { name: 'name1', tags: tags_json, Type: 'c'}})
    Project::Create.(params: { project: { name: 'name2', tags: tags_json, Type: 'a'}})
  end

  context 'with options' do
    context 'per 1 page 1' do
      let(:options) { { per: 1, page: 0 } }

      it 'returns the second page' do
        result = Paginator.new(options, Project).paginate

        assert_equal 1, result.count
        assert_equal 'name1', result.first.name
      end
    end

    context 'per 1 page 2' do
      let(:options) { { per: 1, page: 1 } }

      it 'returns the second page' do
        result = Paginator.new(options, Project).paginate

        assert_equal 1, result.count
        assert_equal 'name2', result.first.name
      end
    end

    context 'per:1 page:0 sort_attr:Type order:asc' do
      let(:options) { {per: 1, page: 0, sort_attr: :Type, order: :asc } }

      it 'returns the first page after sorting by name asc' do
        result = Paginator.new(options, Project).paginate

        assert_equal 1, result.count
        assert_equal 'name2', result.first.name
      end
    end

    context 'per:1 page:0 sort_attr:Type order:desc' do
      let(:options) { {per: 1, page: 0, sort_attr: :Type, order: :desc } }

      it 'returns the first page after sorting by name desc' do
        result = Paginator.new(options, Project).paginate

        assert_equal 1, result.count
        assert_equal 'name1', result.first.name
      end
    end
  end
end
