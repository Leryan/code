# JS test app

Based on:

 - [npm](https://www.npmjs.com/)
 - [browserify](http://browserify.org/)
 - [minifier](https://www.npmjs.com/package/minifier)
 - [jquery](https://jquery.com/)
 - [materialize-css](http://materializecss.com/)

```
npm install
export PATH="$(pwd)/node_modules/.bin/:$PATH"
browserify index.js -o app.js
minify app.js
```
