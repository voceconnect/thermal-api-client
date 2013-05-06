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
  ###
  transition: (route, args)->
    $('.loading').hide()

  ###
  Method for getting posts by page
  Empties the posts container and calls the Controller showPosts method

  @method showPosts
  @param {Number} Query page number
  ###
  showPosts: (paged)->
    WisP.config.html.main.empty()
    WisP.Controller.showPosts(null, paged)

  ###
  Method for getting posts by category

  @method showPostsByCategory
  @param {Number} Category ID
  @param {Number} Query page number
  ###
  showPostsByCategory: (category, paged)->
    WisP.currentPosts = []
    WisP.config.html.main.empty()
    WisP.Controller.showPosts(category, paged)

  showPost: (id)->
    WisP.config.html.main.empty()
    WisP.Controller.showPost(id, false)

  ###
  Displays an error

  @method showError
  ###
  showError: ()->
    WisP.config.html.main.empty()
    WisP.Controller.showError()

  ###
  Starts backbone history

  @method start
  ###
  start: ()->
    Backbone.history.start()
)