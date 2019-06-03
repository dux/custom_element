# DOM window.createElement - polyfill

Polyfill for `window.customElements` with alternative approach

If window.createElement
* is suppoted - we use native `window.customElements` [DOM method](https://developer.mozilla.org/en-US/docs/Web/API/Window/customElements)
* is not supported - we register a node and a method, and we call it in interval to re-bind not binded nodes

## Usage

to install
```
npm add '@dinoreic/custom_element'
```

to use
```
import CustomElement from '@dinoreic/custom_element'
CustomElement.define('dom-node-name', function(dom_node, node_atts) { ... })
```

