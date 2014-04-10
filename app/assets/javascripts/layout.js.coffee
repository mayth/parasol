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

configureFlashes = () ->
  # 'notice' will be closed automatically.
  setTimeout(() ->
    $('.flash .notice').slideUp('fast')
  , 3000)
  # 'alert' will be closed on being clicked.
  $('.flash .alert').click(() ->
    $(this).slideUp('fast')
  )
  # append instruction to close
  $('.flash .alert').append(
    $('<div>').addClass('closing-instruction').text('click to close')
  )

$(document).ready(() ->
  activateMenu()
  addActiveClassInMenu()
  configureFlashes()
  $('pre code').each((i, e) -> hljs.highlightBlock(e))
)