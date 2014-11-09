$(document).on('page:change', () =>
  if /^\/posts\/[0-9]+$/.test(location.pathname)
    $.getJSON('/posts/1.json', (data) =>
      $('.post-body').html(marked(data['body']))
      $('.post-body pre code').each((i, e) => hljs.highlightBlock(e))
    )
)
