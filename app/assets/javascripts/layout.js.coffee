f = (window, document) ->
  layout   = document.getElementById('layout')
  menu     = document.getElementById('menu')
  menuLink = document.getElementById('menuLink')

  toggleClass = (element, className) ->
    classes = element.className.split(/\s+/)
    length = classes.length
    for i in [0..length]
      if classes[i] == className
        classes.splice(i, 1)
        break
    # The className is not found
    if length == classes.length
        classes.push(className)
    element.className = classes.join(' ')

    menuLink.onclick = (e) ->
        active = 'active'

        e.preventDefault()
        toggleClass(layout, active)
        toggleClass(menu, active)
        toggleClass(menuLink, active)

f(this, this.document)