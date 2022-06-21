module ApplicationHelper
  def active_class(path)
    #request.path is current HTTP request path
    if request.path == path
      return 'active'
    else
      return ''
    end
  end
end
