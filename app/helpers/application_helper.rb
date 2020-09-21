module ApplicationHelper
  # TODO: Refactor to use the database to store site to css file mapping so the app is site agnostic
  def site_class
    case request.host
    when 'collect.hugthecenterline.com'
      "htcl"
    when 'collect.illiotide.com'
      "illiotide"
    when 'signup.patriotplatform.com'
      "patriotic_american"
    when 'localhost'
      "illiotide"
    end
  end

  def btn_color
    case request.host
    when 'signup.patriotplatform.com'
      'flag_red'
    # when 'localhost'
    #   'flag_red'
    else
      "btn-warning"
    end
  end
end
