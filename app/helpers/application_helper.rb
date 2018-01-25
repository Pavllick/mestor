module ApplicationHelper
  def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }.stringify_keys[flash_type.to_s] || flash_type.to_s
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)}") do
              concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
              concat message.html_safe
            end)
    end
    nil
  end

  def error_message message
    '*'*16 + ' Error ' + '*'*17 + "\n" + '*'*40 +"\n" + message + "\n" + '*'*40
  end
end
