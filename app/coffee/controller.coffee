###
Main App Controller

@class WisP.Controller
###
WisP.Controller =

  ###
  Does a post query and displays the posts

  @method showPosts
  @param {Number} Category ID
  @param {Number} Query page number
  ###
  showPosts: (category, paged)->
    opts =
      category : null
      paged : 1
    if category? then opts.category = category
    if paged? then opts.paged = paged
    WisP.config.html.main.append(@morePosts(opts))

  ###
  Creates a new Post Collection and View then fetches new posts

  @method morePosts
  @param {Object} Options passed to Collection
  ###
  morePosts: (opts)->
    WisP.currentPosts.push()
    WisP.currentCollection = new WisP.Posts([], opts)
    postsView = new WisP.PostArchiveView(collection : WisP.currentCollection)
    WisP.currentCollection.fetch(success: () ->
      WisP.loadingPosts = false
    )
    postsView.listenTo(WisP.currentCollection, 'add', postsView.renderOne)
    postsView.el

  ###
  Gets and displays a single post

  @method showPost
  @param {Number} Post ID
  ###
  showPost: (id)->
    WisP.currentPost = new WisP.Post(id: id)
    postView = new WisP.PostView(model:WisP.currentPost)
    WisP.currentPost.fetch()
    postView.listenTo(WisP.currentPost, 'change', postView.render)
    WisP.config.html.popup.html(postView.el)