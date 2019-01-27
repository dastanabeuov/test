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

end
