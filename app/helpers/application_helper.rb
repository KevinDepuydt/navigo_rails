module ApplicationHelper
  def flash_class(level)
    case level.to_sym
    when :notice then "notification notice"
    when :success then "notification success"
    when :error then "notification error"
    else "notification error"
    end
  end
end
