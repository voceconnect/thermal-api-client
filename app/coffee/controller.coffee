WisP.Controller =

  showPosts: (category, paged)->
    opts =
      category : null
      paged : 1
    if category? then opts.category = category
    if paged? then opts.paged = paged
    WisP.currentPosts = new WisP.Posts([], opts)
    postsView = new WisP.PostArchiveView(collection : WisP.currentPosts)
    WisP.currentPosts.fetch()
    postsView.render()
    WisP.config.html.main.html(postsView.el)

  showPost: (id)->
    WisP.currentPost = new WisP.Post(id: id)
    postView = new WisP.PostView(model:WisP.currentPost)
    WisP.currentPost.fetch()
    WisP.config.html.popup.html(postView.el)