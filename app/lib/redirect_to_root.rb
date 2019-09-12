# frozen_string_literal: true

class RedirectToRoot < Devise::FailureApp
  def route(_scope)
    :root_path
  end

  def redirect
    store_location!

    redirect_to redirect_url
  end
end
