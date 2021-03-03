module ApplicationHelper
  def flash_class(level)
    flash = {
      'success' => 'ui success message',
      'danger' => 'ui error message',
      'call' => 'ui black message'
    }
    flash[level]
  end
end

# case level
# when 'success' then 'ui success message'
# when 'danger' then 'ui error message'
# when 'call' then 'ui black message'
# end
