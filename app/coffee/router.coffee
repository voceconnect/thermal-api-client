WisP.Router = new (Backbone.Router.extend

  initialize: ()->
    @route("posts(/:category)(/)", 'showPosts')

  showPosts: (category)->
    WisP.Controller.showPosts(category)

  showError: ()->
    console.log 'showError'

  start: ()->
    Backbone.history.start()
)