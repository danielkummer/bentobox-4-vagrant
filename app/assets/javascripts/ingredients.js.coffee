# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $.isJson = (jsonStr) ->
    try
      $.parseJSON jsonStr.toString()
      return true
    catch err
      return false

  $('form').on 'click', '.remove_fields', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('fieldset').hide()
    event.preventDefault()

  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    if $(this).hasClass("embedd_one")
      $(this).remove()
    event.preventDefault()


  $('form').on 'click', '.network-config', (event) ->
    $.each $(this).data(), (key, value) ->
      $("[id$=" + key + "]:last").val(value)

  $('#ingredient_cookbooks').chosen()


  $('form').on 'click', '.share-folder-config', (event) ->
    $.each $(this).data(), (key, value) ->
      $("[id$=" + key + "]:last").val(value)


  $("#ingredient_json_config").on 'keyup', (event)->
    if $.isJson($("#ingredient_json_config").val())
      $(this).parents(".control-group").removeClass("error")
    else
      $(this).parents(".control-group").addClass("error")
