###
App router class
Extends backbone router

@class WisP.Router
###
WisP.Router = new (Backbone.Router.extend
  routes:
    "*path" : "showError"

  ###
  Declares the app routes and listeners

  @method initialize
  ###
  initialize: ()->
    @route("(/:page)(/)", 'showPosts')
    @route("posts(/:page)(/)", 'showPosts')
    @route("posts/category/:category(/:paged)(/)", 'showPostsByCategory')
    @route("posts/show/:id(/)", 'showPost')
    @route("gallery/show/:id(/)", 'showGallery')
    @on('route', @transition)

  ###
  Hides the loading feedback during route event

  @method transition
  @param {Object} The route being used
  @param {Object} Args being passed
  ###
  transition: (route, args)->
    $('.loading').hide()

  ###
  Calls the controller showPosts method
  Passes the paged parameter from the route

  @method showPosts
  @param {Number} Query page number
  ###
  showPosts: (paged)->
    WisP.Controller.showPosts(null, paged)

  ###
  Calls the controller showPosts method
  Passes the category and paged parameter from the route

  @method showPostsByCategory
  @param {Number} Category ID
  @param {Number} Query page number
  ###
  showPostsByCategory: (category, paged)->
    WisP.Controller.showPosts(category, paged)

  ###
  Calls the controller showPost method
  Passes the id parameter from the route

  @method showPost
  @param {Number} The post ID
  ###
  showPost: (id)->
    WisP.Controller.showPost(id)

  ###
  Calls the controller showError method

  @method showError
  ###
  showError: ()->
    WisP.Controller.showError()

  ###
  Starts backbone history

  @method start
  ###
  start: ()->
    Backbone.history.start()
)