# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $("#bentobox_ingredient_ids").chosen()
  $("#bentobox_additional_configuration_ids").chosen()

  toggleAdditional = ->
    $("#additional_configuration").toggle()
    $("#toggle_additional_configuration").children(":first").toggleClass("icon-eye-open").toggleClass "icon-eye-close"


  if $("#bentobox_additional_configuration_ids").val()
    $("#toggle_additional_configuration").button('toggle')
    toggleAdditional()

  $("form").on "click", "#toggle_additional_configuration", (event) ->
    toggleAdditional()
    event.preventDefault()

