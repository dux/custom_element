# Svelte('dialog', function(){
#   this.close()
#   window.$.delay(()=>{ window.scrollTo(0, 0) })
# })
Svelte = (name, func) ->
  if name.includes('*')
    console.error("""Svelte component glob "#{name}*", func not defined""") unless func

    # if giver * glob all execute function
    # Svelte 'filter*', (el) -> el.close()
    name = name.replace '*', ''
    Array.prototype.slice
      .call document.getElementsByTagName("s-#{name}")
      .forEach (el) ->
        func.bind(el.svelte)()

  if el = document.getElementsByTagName("s-#{name}")[0]
    if func
      func.bind(el.svelte)()
    else
      el.svelte
  else
    unless func
      console.error("""Svelte component "#{name}" not found""")

# bind Svelte elements
Object.assign Svelte,
  cnt: 0

  nodesAsList: (root) ->
    list = []

    root.childNodes.forEach (node, i) ->
      if node.attributes
        o = {}
        o.HTML = node.innerHTML
        o.ID = i + 1

        for a in node.attributes
          o[a.name] = a.value

        list.push o

    list

  # bind custom node to class
  bind:(name, klass) ->
    CustomElement.define name, (node, opts) ->
      if node.innerHTML
        if node.innerHTML.indexOf('</slot>') > -1
          opts.slots = Svelte.nodesAsList node
        else
          opts.innerHTML = node.innerHTML
          node.innerHTML = ''

      global = null
      if opts.global
        global  = opts.global
        delete opts.global

      element = new klass({ target: node, props: opts })
      window[global] = element if global
      node.svelte = element

export default Svelte