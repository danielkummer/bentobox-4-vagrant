# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('.dropdown-toggle').dropdown()
  $('.dropdown input, .dropdown label').click (e) ->
    e.stopPropagation()


  $('#chefServerState').popover()

  $.getJSON $('#chef_server_status').data('url'), (data) ->
    badge = (if data["reachable"] is "true" then "success" else "important")
    $('#chef_server_status').html($('<span class="badge badge-' + badge + '"><i class="icon-globe"></i></span>'))

  $.getJSON $('#chef_client_status').data('url'), (data) ->
    if data["client_exists"] is true
      badge = "success"
      icon = "icon-ok-circle"
      statusText = "client exists on chef server"
    else
      badge = "important"
      icon = "icon-remove-circle"
      statusText = "client doesn't exist on chef server"

    $('#chef_client_status').html(
      $('<span class="badge badge-' + badge + '"><i class="' + icon + '"></i> ' + statusText + '</span>')
    )
