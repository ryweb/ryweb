# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def calendar?
    if params[:view].to_s == "list"
      true
    else
      false
    end
  end
end
