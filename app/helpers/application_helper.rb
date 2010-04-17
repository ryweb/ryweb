# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def calendar?
    if params[:view].to_s == "list"
      true
    else
      false
    end
  end

  def current(args)
    if args.include?(params[:controller])
      return ' class="current"'
    end
  end
end
