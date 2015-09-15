# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
searches =
  init: ->
    @providerSelector()
  providerSelector: ->
    $("#provider-selector").change ->
      self = $(this)
      if self.data("searchId")
        $.get '/searches/provider_form?provider=' + $(this).val() + "&id=" + self.data('searchId')
      else
        $.get '/searches/provider_form?provider=' + $(this).val()

@app.searches = searches
