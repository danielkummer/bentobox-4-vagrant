# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('#bentobox_ingredient_ids').chosen()
  $('#bentobox_additional_configurations').chosen()
  $('#toggle_additional_configuration')
  $('form').on 'click', '#toggle_additional_configuration', (event) ->
    $('#additional_configuration').toggle()
    $('#toggle_additional_configuration').children(":first").toggleClass("icon-eye-open").toggleClass("icon-eye-close")
    if ( $('#additional_configuration').css('display') == 'block' )
      #$(this).html($(this).html().replace(/Show/, "Hide"));
    else
      #$(this).html($(this).html().replace(/Hide/, "Show"));
    event.preventDefault()

