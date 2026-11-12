module ApplicationHelper
  def photo_url(photo, **options)
    return asset_path('vesper.png') if ENV['CLOUDINARY_CLOUD_NAME'].blank? || photo.blank?
    cl_image_path(photo, **options)
  end

  def inline_svg(name)
    file_path = "#{Rails.root}/app/assets/images/svg/#{name}.svg"
    return File.read(file_path).html_safe if File.exist?(file_path)
    '(not found)'
  end
end
