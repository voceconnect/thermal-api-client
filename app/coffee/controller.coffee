###
Main App Controller

@class WisP.Controller
###
WisP.Controller =

  showCategoriesMenu: (opts)->
    WisP.categories = new WisP.Terms [], opts
    categoryMenuView = new WisP.CategoryMenuView
      collection: WisP.categories
      el: WisP.config.html.categorySelect

    WisP.categories.fetch()

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

  ###
  Gets and displays a single post

  @method showPost
  @param {Number} Post ID
  @param {Boolean} popup
  ###
  showPost: (id, popup = true)->
    if WisP.getPostByID(id).length > 0
      WisP.currentPost = WisP.getPostByID(id)[0]
      postView = new WisP.PostView(model:WisP.currentPost)
      postView.render()
    else
      WisP.currentPost = new WisP.Post(id: id)
      WisP.currentPost.fetch()
      postView = new WisP.PostView(model:WisP.currentPost)
    if popup is true
      WisP.config.html.popup.html(postView.el)
    else
      WisP.config.html.main.html(postView.el)


  showError: ()->
    WisP.config.html.main.append(WisP.Templates['404.html'])
