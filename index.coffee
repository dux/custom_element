# create DOM custom element or polyfil for older browsers
DOMCustomElement =
  ping_interval: 100
  data: {}

  attributes: (node) ->
    o = {}
    i = 0

    while el = node.attributes[i]
      o[el.name] = el.value;
      i++

    o

  define: (name, func) ->
    if window.customElements
      customElements.define name, class extends HTMLElement
        constructor: ->
          super()
          window.requestAnimationFrame =>
            func @, DOMCustomElement.attributes(@)
    else
      @data[name] = func

  # manual node bind
  lazy: ->
    for name, func of @data
      for node in Array.from(document.querySelectorAll("#{name}:not(.mounted)"))
        node.classList.add('mounted')
        func node, @attributes(node)


# manual bind for old browsers
unless window.customElements
  setInterval =>
    DOMCustomElement.lazy()
  , DOMCustomElement.ping_interval

export default DOMCustomElement.define.bind(DOMCustomElement)