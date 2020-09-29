# frozen_string_literal: true

# View helpers, primarily concerned with adjusting styles
module ApplicationHelper
  # TODO: Refactor to use the database to store site to css file mapping so the app is site agnostic
  def site_class
    # case request.domain(n = 2) # removed for rubocop "useless assignment to variable"
    case request.domain(n)
    when 'patriotplatform.com'
      'patriotic_american'
    when 'greymanhw.com'
      'grey'
    when 'localhost'
      'grey'
    end
  end

  def btn_color
    # case request.domain(n = 2) # removed for rubocop "useless assignment to variable"
    case request.domain(n)
    when 'patriotplatform.com'
      'flag_red'
    when 'greymanhw.com'
      'btn-warning'
    when 'localhost'
      'btn-warning'
    else
      'btn-warning'
    end
  end
end
