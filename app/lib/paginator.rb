class Paginator
  attr_accessor :per, :page, :sort_attr, :order

  def initialize(options, clazz)
    @per = options[:per]
    @page = options[:page]
    @sort_attr = options[:sort_attr]
    @order = options[:order]
    @clazz = clazz
  end

  def paginate
    if @sort_attr.nil?
      return paginate_only
    else
      return sort_and_paginate 
    end
  end

  private
  def sort_and_paginate
    @clazz.
      order(@sort_attr => @order).
      offset(@page * @per).
      limit(@per)
  end

  def paginate_only
    @clazz.
      offset(@page * @per).
      limit(@per)
  end
end
