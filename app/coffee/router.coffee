WisP.Router = new Backbone.Router.extend

  initialize: ()->
    @route("posts(/:category)(/)", 'showPosts')

  showPosts: (category)->
    if category?
      @posts = new WisP.Posts({category: category})
    else
      @posts = new WisP.Posts()

  showError: ()->
    console.log 'showError'

  start: ()->
    Backbone.history.start()
