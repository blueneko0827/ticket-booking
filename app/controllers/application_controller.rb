class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  layout :layout_by_resource
  before_action :authenticate_user!


  def layout_by_resource
    return "devise" if devise_controller? # special definition in devise

    "application"
  end
end
