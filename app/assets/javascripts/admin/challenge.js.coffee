$(() ->
  $(document).on('nested:fieldAdded:flags', (e) ->
    e.field.addClass('new-field')
  )
  $(document).on('nested:fieldRemoved:flags', (e) ->
    if (e.field.hasClass('new-field'))
      e.field.remove()
  )
)