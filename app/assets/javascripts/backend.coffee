# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  ShareThisTurbolinks.reload()

# if you're using jquery.turbolinks, you don't need this binding
$(document).on 'page:load', ->
  ShareThisTurbolinks.reload()

$(document).on 'page:restore', ->
  ShareThisTurbolinks.restore()

ShareThisTurbolinks =
  load: ->
    window.switchTo5x = false
    $.getScript 'https://ws.sharethis.com/button/buttons.js', ->
      window.stLight.options
        publisher: 'your-publisher-id'

  reload: ->
    stlib?.cookie.deleteAllSTCookie()
    $('[src*="sharethis.com"], [href*="sharethis.com"]').remove()
    window.stLight = undefined
    @load()

  restore: ->
    $('.stwrapper, #stOverlay').remove()
    @reload()
