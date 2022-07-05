# frozen_string_literal: true

module ItemsHelper
  def select_category_id(item)
    item.categories.first.id
  end
end
