# create DOM custom element or polyfil for older browsers
CustomElement =
  data: {}
  dom_loaded: false

  attributes: (node) ->
    Array.prototype.slice
      .call(node.attributes)
      .reduce (h, el) ->
        h[el.name] = el.value;
        h
      , {}

  # define custom element
  define: (name, func) ->
    if window.customElements
      customElements.define name, class extends HTMLElement
        connectedCallback: ->
          if CustomElement.dom_loaded
            func @, CustomElement.attributes(@)
          else
            # we need to delay bind if DOM is not loaded
            window.requestAnimationFrame =>
              func @, CustomElement.attributes(@)

    else
      @data[name] = func


# pollyfill for old browsers
unless window.customElements
  setInterval =>
    for name, func of CustomElement.data
      for node in Array.from(document.querySelectorAll("#{name}:not(.mounted)"))
        node.classList.add('mounted')
        func node, CustomElement.attributes(node)
  , 100

# when document is loaded we can render nodes without animation frame
document.addEventListener "DOMContentLoaded", ->
  CustomElement.dom_loaded = true

# # bind react elements
# bind_react: (name, klass) ->
#   @define name, (node, opts) ->
#     element = React.createElement klass, opts, node.innerHTML
#     ReactDOM.render element, node

export default CustomElement