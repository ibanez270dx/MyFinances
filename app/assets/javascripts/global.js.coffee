
$(document).ready ->

  # Automatically dismiss flash messages after 5 seconds
  setTimeout ->
    $('a[data-dismiss=alert]').click()
  , 10000
