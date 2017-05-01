module ApplicationHelper
  def screenshot_image_tag(url)
    image_tag "http://api.page2images.com/directlink?p2i_url=#{url}&p2i_key=#{ENV['PAGE2IMAGES_API']}&p2i_device=0&p2i_size=150x150&p2i_screen=1280x800"
  end
end