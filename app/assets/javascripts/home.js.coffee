$(document).on('page:change', () =>
  if /^\/rules\/?$/.test(location.pathname)
    $.getJSON('/rules.json', (data) =>
      $('.content').html(marked(data['rules']))
      $('.content pre code').each((i, e) => hljs.highlightBlock(e))
    )
)
