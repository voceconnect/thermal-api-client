WisP.Controller =

  showPosts: (category, paged)->
    opts =
      category : null
      paged : 1
    if category? then opts.category = category
    if paged? then opts.paged = paged
    WisP.config.html.main.append(@morePosts(opts))

  morePosts: (opts)->
    WisP.currentCollection = new WisP.Posts([], opts)
    postsView = new WisP.PostArchiveView(collection : WisP.currentCollection)
    WisP.currentCollection.fetch(success: () ->
      for m in WisP.currentCollection.models
        if WisP.getPostByID(m.get('id')).length is 0
          WisP.currentPosts.push($.extend(true, {}, m))
      WisP.loadingPosts = false
    )
    postsView.listenTo(WisP.currentCollection, 'add', postsView.renderOne)
    postsView.el

  showPost: (id)->
    if WisP.getPostByID(id).length > 0
      WisP.currentPost = WisP.getPostByID(id)[0]
      postView = new WisP.PostView(model:WisP.currentPost)
      postView.render()
    else
      WisP.currentPost = new WisP.Post(id: id)
      WisP.currentPost.fetch()
      postView = new WisP.PostView(model:WisP.currentPost)
    postView.listenTo(WisP.currentPost, 'change', postView.render)
    WisP.config.html.popup.html(postView.el)

  showError: ()->
    WisP.config.html.main.append(WisP.Templates['404.html'])