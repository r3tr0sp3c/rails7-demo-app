module ApplicationHelper
  def turbo_stream_flash_message
    turbo_stream.prepend 'flash', partial: 'layouts/notifications'
  end

end
