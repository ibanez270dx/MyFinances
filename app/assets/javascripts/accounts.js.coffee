# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'page:load', ->

  # Institution Selector Change
  $('#token_institution').on 'change', (event) ->
    institution = $(this).val()
    $(".js-credentials:visible").slideUp 'fast', (event) ->
      $(".js-credentials.#{institution}").slideDown('fast')

  # Open the first selection on ready
  institution = $('#token_institution').val()
  $(".js-credentials.#{institution}").show()
