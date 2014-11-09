$(document).on('page:change', () =>
  result = /^\/admin\/posts\/([0-9]+)\/?$/.exec(location.pathname)
  if result
    $.getJSON("/admin/posts/#{result[1]}.json", (data) =>
      $('.post-body').html(marked(data['body']))
      $('.post-body pre code').each((i, e) -> hljs.highlightBlock(e))
    )
)
