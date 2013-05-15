# WisP

_A Backbone JS powered client for viewing WordPress posts served by the [Thermal WordPress API plugin](http://thermal-api.com_)._

## Application Description

The application has a namespace of `WisP`. All classes are bound to it.
e.g.

* `WisP.Post` for a post model
* `WisP.Templates['post-excerpt.html']` for the Underscore template to render
a post excerpt

## Application Structure

```
 |-/app
 |---coffee # Classes and helper methods to power the app
 |-----collections # Backbone collections
 |-----models # Backbone models
 |-----views # Backbone views
 |---images # Custom application images
 |---sass # Application styles
 |---templates # HTML template files using Underscore
 |-/tasks # Peon tasks for custom build
 |-/tests # Unit tests via testem
 |-/vendor # Third Party assets
 |---css
 |---images
 |---js
 |-/_build # Compiled application to be set as the web server's document root
 |---css # Merging application and vendor styles
 |---js # Concatenated JavaScript from application and vendor
 |---img # Application and vendor images
 |---tpl # Minified HTML from /app/templates
 ```

## Build Process

We are porting the build process into grunt, but in the meantime there is a
`build-v*.zip` file of the `_build` directory you can extract. Once you do
that, open `index.html` in a browser to see sample posts from
[http://sandbox.thermal-api.com](http://sandbox.thermal-api.com). 

If you are running the [http://thermal-api.com](Thermal plugin) on your
WordPress site you can edit `index.html` and change the `apiUrl` to your site.

## Testing

Open domain/tests/index.html to run the tests.


## Embedding

The application can be run inside another site using the WisP.Embed class:

* Include the `PATHTOWISP/js/wisp.js` file into your site
* Create a HTML element to contain the app
* Instantiate a WisP.Embed object with your options

```javascript
<script>
jQuery(document).ready(function($){
    var wispOptions = {
        elSelector: '#embed_in_me', // the HTML container element selector
        apiUrl: 'http://domain.tld/wp_api/v1', // The Thermal API domain
        perPage: 5 // How many posts to show per page
        },
    wispEmbed = new WisP.Embed(wispOptions);
});
</script>
```



## Changelog

* 1.0 - Initial release
