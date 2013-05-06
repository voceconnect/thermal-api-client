###
Global App Object
Holds the global config options and methods
###
window.WisP =

  proxiedSync: Backbone.sync
  config:
    baseUrl: ''
    per_page: 3
    html :
      categorySelect: $('#category-dropdown')
      main: $('#main')
  loadingPosts : false
  currentPost : {}
  currentPosts : []
  currentCollection : {}

  ###
  App initialize method
  Kicks off the functionality

  @method init
  ###
  init:()->
    @setupMasonry()
    @setupScrolling()
    @setupClickEvents()
    @setupDropdown()

  ###
  Instantiates the bootstrap dropdown and click binding

  @method setupDropdown
  ###
  setupDropdown: ()->
    html = WisP.config.html
    container = html.main
    container.find('.dropdown-toggle').dropdown()
    # Category dropdown list
    html.categorySelect.on('click', '.category-menu-item a', (e)->
      e.preventDefault()
      catID = $(@).attr('href')
        .substr($(@).attr('href')
        .lastIndexOf('/'))
        .replace('/', '')
      WisP.Controller.showPosts(catID)
    )

  ###
  Instantiates the jQuery Masonry

  @method setupMasonry
  ###
  setupMasonry: ()->
    if @config.html.main.data('masonry')?
      @config.html.main.masonry( 'reload' )
    else
      @config.html.main.masonry(
        itemSelector: '.thermal-item'
        columnWidth: 300
      )

  ###
  Adds the scroll listener
  Shows the scroll to top button and infinite scroll

  @method setupScrolling
  ###
  setupScrolling: ()->
    $scrollToTop = $('.scroll-to-top')
    $(window).scroll(()->
      if $(@).scrollTop() > 100
        $scrollToTop.fadeIn()
      else
        $scrollToTop.fadeOut()
      $lastItem = $('.thermal-loop').find('.thermal-item').last()
      if $lastItem.length > 0 then iTop = $lastItem.position().top else return
      scrollTop = $(window).scrollTop()
      if iTop >= scrollTop or
      (scrollTop + $(window).height()) > ($(document).height() - 100)
        if WisP.loadingPosts is false and
        WisP.currentCollection.found > WisP.currentPosts.length
          opts =
            category : WisP.currentCollection.category
            paged : parseInt(WisP.currentCollection.paged, 10) + 1
          WisP.config.html.main.append(WisP.Controller.morePosts(opts))
          WisP.loadingPosts = true
    )
    $scrollToTop.click((e)->
      e.preventDefault()
      $("html, body").animate({ scrollTop: 0 }, 600)
    )

  ###
  Creates misc click listeners for the app

  @method setupClickEvents
  ###
  setupClickEvents: ()->
    html = WisP.config.html
    container = html.main
    controller = WisP.Controller
    # Post card links for post view
    container.on('click', '.thermal-item a.post-link', (e)->
      e.preventDefault()
      id = $(@).attr('href')
        .substr($(@).attr('href')
        .lastIndexOf('/'))
        .replace('/', '')
      controller.showPost(id)
    )
    # Show posts button on single post view
    container.on('click', '.show-posts', (e)->
      e.preventDefault()
      controller.showPosts()
    )
    # Next and prev buttons on single post view
    container.on('click', '.post-paging a', (e)->
      e.preventDefault()
      post = WisP.currentPost
      postID = post.get('id')
      elID = $(@).attr('id')
      if elID is 'prev-post'
        post = WisP.stepPost(postID, true)
      else if elID is 'next-post'
        post = WisP.stepPost(postID)
      if postID is post.get('id') then return
      controller.showPost(post.get('id'))
    )

  ###
  Get a single image from an array given a specific ID
  e.g. Get the featured image from a post media array

  @method getMediaByID
  @param {Number} ID of the image to search for (needle)
  @param {Array} The Array of media Objects to search (haystack)
  @return {Mixed} Return an Object on success or FALSE on failure
  ###
  getMediaByID : (id, images) ->
    q = _.where(images, {id: id})
    if q.length > 0
      if not q[0].alt_text
        q[0].alt_text = ""
      if q[0].sizes and q[0].sizes.length > 0
        if q[0].sizes[0].url
          return q[0]
    false

  ###
  Get a single post from currentPosts by id

  @method getPostByID
  @param {Number} The ID of the post being retrieved
  @return {Array} Array containing the post or empty if not found
  ###
  getPostByID: (id)->
    id = parseInt(id, 10)
    r = []
    for post in WisP.currentPosts
      if post.get('id') is id then r.push(post)
    r

  ###
  Find the next or previous post in currentPosts

  @method stepPost
  @param {Number} ID of the current post
  @param {Boolean} Whether or not to get previous post
  @return {Object} Post found, defaults to current post
  ###
  stepPost: (id, prev = false)->
    id = parseInt(id, 10)
    rPost = WisP.currentPost
    for k,post of WisP.currentPosts
      idx = (parseInt(k, 10) + 1)
      if prev is true then idx = (parseInt(k, 10) - 1)
      if post.get('id') is id and WisP.currentPosts[idx]
        rPost = WisP.currentPosts[idx]
    rPost

  ###
  Get the pretty url for the single post view

  @method getPrettyURL
  @param {String} Original Url to parse
  @return {Mixed} Pretty URL String or false
  ###
  getPrettyURL: (url)->
    regex = /((https?:\/\/)(www\.)?)(\S*?)(\/)/ig
    result = regex.exec(url)
    if result and result[4]
      return result[4]
    false

  ###
  Find closes size from an array of sizes

  @method getMediaByWidth
  @param {Array} Array of sizes for a media object
  @param {Number} The target width to look for
  @return {Mixed} Single size or false
  ###
  getMediaByWidth: (sizes, width)->
    smallest = false
    if sizes.length > 0 && width
      _.each sizes, (media, key, list)->
        if not smallest and media.width >= width
          smallest = media
        else if media.width < smallest.width and media.width >= width
          smallest = media
      if not smallest
        smallest = _.max sizes, (size)->
          return size.width
    return smallest
