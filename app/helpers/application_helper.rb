module ApplicationHelper
  # TODO: Refactor to use the database to store site to css file mapping so the app is site agnostic
  def site_class
    case request.domain(n=2)
    when 'hugthecenterline.com'
      "patriotic_american"
    when 'patriotplatform.com'
      "patriotic_american"
    when 'greymanhw.com'
      "grey"
    when 'localhost'
      "grey"
    end
  end

  def btn_color
    case request.domain(n=2)
    when 'hugthecenterline.com'
      'flag_red'
    when 'patriotplatform.com'
      'flag_red'
    when 'greymanhw.com'
      'btn-warning'
    when 'localhost'
      'btn-warning'
    else
      "btn-warning"
    end
  end
end
