$(() ->
  $(document).on('nested:fieldAdded:flags', (e) ->
    e.field.addClass('new-field')
  )
  $(document).on('nested:fieldRemoved:flags', (e) ->
    if (e.field.hasClass('new-field'))
      e.field.remove()
  )
)

$(document).on('page:change', () =>
  result = /^\/admin\/challenges\/([0-9]+)\/?$/.exec(location.pathname)
  if result
    $.getJSON("/admin/challenges/#{result[1]}", (data) =>
      $('#description-body').html(marked(data['description']))
      $('#description-body pre code').each((i, e) => hljs.highlightBlock(e))
    )
)
