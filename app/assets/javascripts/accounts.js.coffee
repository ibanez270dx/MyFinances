# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->

  # Institution Selector Change
  $('#institution').on 'change', (event) ->
    institution = $(this).val()
    $(".js-credentials:visible input").prop('disabled', true)
    $(".js-credentials:visible").slideUp 'fast', (event) ->
      $(".js-credentials.#{institution} input").prop('disabled', false)
      $(".js-credentials.#{institution}").slideDown('fast')

  # Open the first selection on ready
  institution = $('#institution').val()
  $(".js-credentials.#{institution}").show()
  $(".js-credentials.#{institution} input").prop('disabled', false)
