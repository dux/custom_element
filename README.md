# DOM window.createElement - polyfill

Polyfill for `window.createElement` with alternative approach

If window.createElement
* is suppoted - we use native `window.createElement` [DOM method](https://developer.mozilla.org/en-US/docs/Web/API/Document/createElement)
* is not supported - we register a node and a method, and we call it in interval to re-bind not binded nodes

## Usage

to install
```
npm add '@dinoreic/create_element'
```

to use
```
import createElement from '@dinoreic/create_element'
createElement('dom-node-name', callback_func(dom_node, node_atts) { ... })
```

## Example usage for [Svelte JS FW](https://svelte.dev)

this will make `<s-tabs>...tab data</s-tabs>` render tabs

```
import createElement from '@dinoreic/create_element'

let bindSvelteToDOM = function(name, klass) {
  createElement(name, function(node, opts) {
    # export innerHTML
    opts.innerHTML = node.innerHTML
    node.innerHTML = ''

    let element = new klass({ target: node, props: opts })

    # define global if global name given
    if (opts.global) {
      window[opts.global] = element
    }
  })
}

import SvelteTab from './svelte/tabs.svelte'
bindSvelteToDOM('s-tabs', SvelteTab)
```