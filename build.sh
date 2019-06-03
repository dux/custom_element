npx coffee -c -o dist/svelte.js         src/svelte.coffee
npx coffee -c -o dist/custom_element.js src/custom_element.coffee

npm publish --access public
