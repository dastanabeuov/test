module ApplicationHelper
  
  def show_flash(type)
    content_tag :p, flash[type], class: "flash #{type}" if flash[type]
  end

  def current_year
    Time.current.year
  end

  def github_url(author, repo)
    "https://github.com/#{ author }/#{ repo }"
  end

  def flash_message(type, message)
    content_tag(:p, message, class: "alert #{FLASH_TYPES[type.to_sym]}")
  end

  FLASH_TYPES = {
    success: 'alert-success',
    notice: 'alert-warning',
    alert: 'alert-danger'
  }.freeze  

end
