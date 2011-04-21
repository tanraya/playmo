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

  def admin_area(&block)
    if user_signed_in?
      content = with_output_buffer(&block)
      content_tag(:div, content, :class => 'admin')
    end
  end

  def link_to_section(name, options = {}, html_options = {}, &block)
    url_string = url_for(options)

    if "/#{request.path.split('/')[1]}" == url_string
      html_options[:class] = "#{html_options[:class]} current"
    end

    link_to(name, options, html_options, &block)
  end

  def page_id
    name = 'page-' + request.path_parameters[:controller] + '-' + request.path_parameters[:action]
    name.gsub!(/_+/, '-')
    name
  end

  def link_to_website(url, html_options = {})
    return nil if url.blank?
    
    url = "http://#{url}" unless url =~ /^(ht|f)tps?:\/\//i
    html_options[:href] = url
    content_tag(:a, url, html_options)
  end
end
