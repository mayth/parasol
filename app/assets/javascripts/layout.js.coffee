$(document).ready(() ->
  $('#menuLink').click((e) ->
    active = 'active'

    e.preventDefault()
    $('#layout').toggleClass(active)
    $('#menu').toggleClass(active)
    $('#menuLink').toggleClass(active)
  )
  $('pre code').each((i, e) -> hljs.highlightBlock(e))
)