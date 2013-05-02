###
Global App Object
Holds the global config options
###
window.WisP =

  proxiedSync: Backbone.sync
  config:
    baseUrl: ''
    per_page: 3
    html :
      categorySelect: $('#category-dropdown')
      main: $('#main')
      popup: $('#popup')
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
    $scrollToTop = $('.scroll-to-top')
    $(window).scroll(()->
      if $(@).scrollTop() + $(window).height() > $(document).height() - 100
        if WisP.loadingPosts is false and
        WisP.currentCollection.found > WisP.currentPosts.length
          opts =
            category : WisP.currentCollection.category
            paged : parseInt(WisP.currentCollection.paged, 10) + 1
          WisP.config.html.main.append(WisP.Controller.morePosts(opts))
          WisP.loadingPosts = true
      if $(@).scrollTop() > 100
        $scrollToTop.fadeIn()
      else
        $scrollToTop.fadeOut()
    )

    $scrollToTop.click((e)->
      e.preventDefault()
      $("html, body").animate({ scrollTop: 0 }, 600)
    )
    $('.dropdown-toggle').dropdown()
    WisP.config.html.main.on('click', '.thermal-item h4 a', (e)->
      e.preventDefault()
      id = $(@).attr('href')
        .substr($(@).attr('href')
        .lastIndexOf('/'))
        .replace('/', '')
      WisP.Controller.showPost(id)
      WisP.config.html.popup.modal('toggle')
    )
    WisP.config.html.popup.on('click', '.modal-close', (e)->
      e.preventDefault()
      WisP.config.html.popup.modal('hide')
    )
    WisP.config.html.popup.on('click', '.post-paging a', (e)->
      e.preventDefault()
      post = WisP.currentPost
      postID = post.get('id')
      elID = $(@).attr('id')
      if elID is 'prev-post'
        post = WisP.stepPost(postID, true)
      else if elID is 'next-post'
        post = WisP.stepPost(postID)
      if postID is post.get('id') then return
      WisP.Controller.showPost(post.get('id'))
    )
    WisP.Controller.showCategoriesMenu()

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

  getPostByID: (id)->
    id = parseInt(id, 10)
    r = []
    for post in WisP.currentPosts
      if post.get('id') is id then r.push(post)
    r

  stepPost: (id, prev = false)->
    id = parseInt(id, 10)
    rPost = WisP.currentPost
    for k,post of WisP.currentPosts
      idx = (parseInt(k, 10) + 1)
      if prev is true then idx = (parseInt(k, 10) - 1)
      if post.get('id') is id and WisP.currentPosts[idx]
        rPost = WisP.currentPosts[idx]
    rPost

  getPrettyURL: (url)->
    regex = /((https?:\/\/)(www\.)?)(\S*?)(\/)/ig
    result = regex.exec(url)
    if result and result[4]
      return result[4]
    false

Backbone.sync = (method, model, options) =>
  if typeof model.url is "string"
    matches = model.url.match(/(https?:\/\/)?[\w-]+(\.[\w-]+)+\.?/i)
    if matches and
    matches[0].replace(/http(s)?:\/\//, '') isnt window.location.host
      options.dataType = "jsonp"
  WisP.proxiedSync(method, model, options)

###
Is this date "new" within the last day

@module Date
@method isNew
@return Boolean
###
Date.prototype.isNew = ()->
  d = new Date(this)
  now = new Date()
  if (now.getTime() - d.getTime()) <= 86400000 then return true
  false

###
Format date object like "x minutes ago, y days ago, etc"

@module Date
@method timeAgo
###
Date.prototype.timeAgo = ()->
  date = new Date(this)
  diff = (((new Date()).getTime() - date.getTime()) / 1000)
  day_diff = Math.floor(diff / 86400)
  if isNaN(day_diff) or day_diff < 0 then return
  months = [
    'January'
    'February'
    'March'
    'April'
    'May'
    'June'
    'July'
    'August'
    'September'
    'October'
    'November'
    'December'
  ]
  tAgo = "#{months[date.getMonth()]} #{date.getDate()}, #{date.getFullYear()}"
  if day_diff is 0
    if diff < 60 then tAgo = 'just now'
    else if diff < 120 then tAgo = '1 minute ago'
    else if diff < 3600 then tAgo = Math.floor( diff / 60 ) + " minutes ago"
    else if diff < 7200 then tAgo = '1 hour ago'
    else if diff < 86400 then tAgo = Math.floor( diff / 3600 ) + " hours ago"
  else
    if day_diff is 1 then tAgo = 'Yesterday'
    else if day_diff < 7 then tAgo = "#{day_diff} days ago"
    else if day_diff < 31 then tAgo = Math.ceil( day_diff / 7 ) + " weeks ago"

  return tAgo
