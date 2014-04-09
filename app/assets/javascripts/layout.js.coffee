activateMenu = () ->
  $('#menuLink').click((e) ->
    active = 'active'

    e.preventDefault()
    $('#layout').toggleClass(active)
    $('#menu').toggleClass(active)
    $('#menuLink').toggleClass(active)
  )

addActiveClassInMenu = () ->
  page_id = $('body').attr('id').replace(/_/g, ' ')
  e = $.grep(
    $('#menu ul li a'),
    (n, i) -> page_id == $(n).text().toLowerCase()
  )
  if e
    $(e[0]).parent().addClass('pure-menu-selected')

$(document).ready(() ->
  activateMenu()
  addActiveClassInMenu()
  $('pre code').each((i, e) -> hljs.highlightBlock(e))
)