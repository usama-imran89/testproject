# frozen_string_literal: true

module ApplicationHelper
  def active_class(path)
    # request.path is current HTTP request path
    if request.path == path
      'active'
    else
      ''
    end
  end
end
