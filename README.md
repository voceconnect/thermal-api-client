# wpJsonApiClient

_A Backbone JS powered webapp for viewing WordPress posts_

The app has two implementations.
1. A standalone web application that can be run from anywhere.
2. A WordPress theme that is loaded like any other

## Application Structure
```
 |-/app
 |---coffee
 |-----collections
 |-----models
 |-----views
 |---images
 |---sass
 |---templates
 |-/docs
 |-/tasks # Peon tasks for custom build
 |-/tests
 |-/vendor # Third Party assets (possibly load via package manager)
 |---css
 |---images
 |---js
 |-/webapp
 |---assets # Compiled assets from the /app directory
 |---tpl # Minified HTML from /app/templates
 |---vendor # Copy of /vendor
 |-/wp-theme
 |---assets # Copy of compiled assests from the /app directory
 |---vendor # Copied vendor assets from project root
 |---functions.php # Enqueue the scripts and styles
 |---styles.css # Required for theme header
 |---index.php # Load the app here
 ```

## Build Process

There is a custom `peon-config.jst` which is properly configured for this application structure.
There are also custom tasks in the /tasks directory for the build.
Run `peon build` from the root of the project to produce functional standalone and WP implementations of this application.


## Changelog