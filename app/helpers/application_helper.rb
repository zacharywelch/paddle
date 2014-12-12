module ApplicationHelper
  # Used to append a css class to the body tag.
  def body_class(klass)
    ['fill-light', klass].compact.join(' ')
  end  
end
