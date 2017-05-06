module ApplicationHelper
  def screenshot_image_tag(url)
    image_tag "http://api.page2images.com/directlink?p2i_url=#{url}&p2i_key=#{ENV['PAGE2IMAGES_API']}&p2i_device=0&p2i_size=150x150&p2i_screen=1280x800"
  end

  def nav_link(link_text = nil, link_path, &block)
    class_name = current_page?(link_path) ? 'active' : ''

    content_tag(:li, :class => class_name) do
      if block_given?
        link_to link_path, &block
      else
        link_to link_text, link_path
      end
    end
  end
end
