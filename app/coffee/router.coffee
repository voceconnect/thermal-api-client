WisP.Router = new (Backbone.Router.extend

  initialize: ()->
    @route("posts(/:category)(/)", 'showPosts')
    @on('route', @transition)

  transition: (route, args)->
    $('.loading').hide()

  showPosts: (category)->
    WisP.Controller.showPosts(category)

  showError: ()->
    console.log 'showError'

  start: ()->
    Backbone.history.start()
)