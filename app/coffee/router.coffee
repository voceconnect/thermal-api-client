WisP.Router = new (Backbone.Router.extend

  initialize: ()->
    @route("(/:page)(/)", 'showPosts')
    @route("posts(/:page)(/)", 'showPosts')
    @route("posts/category/:category(/:paged)(/)", 'showPostsByCategory')
    @on('route', @transition)

  transition: (route, args)->
    $('.loading').hide()

  showPosts: (paged)->
    WisP.config.html.main.empty()
    WisP.Controller.showPosts(null, paged)

  showPostsByCategory: (category, paged)->
    WisP.config.html.main.empty()
    WisP.Controller.showPosts(category, paged)

  showError: ()->
    WisP.config.html.main.empty()
    console.log 'showError'

  start: ()->
    Backbone.history.start()
)