## Requirejs with routing

This script allow you to use requirejs depending on routes.

### Build

```
$ npm install
$ gulp
```

### Use

Create script named `app.website.js`, require `app.js` with requirejs, use `app` function to create new App instance and define routes in callback:

```javascript
require(['app'], function () {
    
    // This will load jquery and transit modules by default on all pages
    app(['jquery', 'transit'], function (app) {
        
        // Load foo and bar scripts for index page
        app.require(['/'], ['foo', 'bar']);
        
        // Load foo script for /bar page and then load bar script through callback function
        app.require(['/bar'], ['foo'], function () {
            app.require(['bar']);
        });
        
        // Require bar script on all /foo/* pages
        app.require(['/foo/*'], ['bar']);
    });
});
```

And finally include it in your page:

```html
<script data-main="/js/app.website" src="/js/require.js"></script>
```