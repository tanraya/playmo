module ApplicationHelper
  attr_accessor :page_title

  # Set page title. Use this method in your views
  def title(page_title)
    @page_title = page_title
  end

  # This prints page title. Call this helper
  # inside title tag of your layout
  def page_title(default_title = '')
    @page_title || default_title
  end

  # Print heading (h1 by default) and set page title
  # at the same time. Use this method in your views
  def heading_with_title(heading, tag=:h1)
    title(heading)
    content_tag tag, heading
  end
end
