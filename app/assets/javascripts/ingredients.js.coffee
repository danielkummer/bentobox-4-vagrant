# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
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
    type = $(this).data('type')
    second_param = $(this).data('second-parameter')
    third_param = $(this).data('third-parameter')

    $('#ingredient_networkconfig_attributes_type').val(type)
    $('#ingredient_networkconfig_attributes_second_parameter').val(second_param)
    $('#ingredient_networkconfig_attributes_third_parameter').val(third_param)
