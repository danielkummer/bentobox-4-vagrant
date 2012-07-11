# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('.dropdown-toggle').dropdown()
  $('.dropdown input, .dropdown label').click (e) ->
    e.stopPropagation()