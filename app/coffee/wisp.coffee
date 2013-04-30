window.WisP =
  config:
    baseUrl: ""
    per_page: 3
    html :
      categorySelect: $('#category-dropdown')
      main: $('#main')
      popup: $('#popup')

  init:()->
    $(window).scroll(()->
      if $(this).scrollTop() > 100
        $('.scroll-to-top').fadeIn()
      else
        $('.scroll-to-top').fadeOut()
    )

    $('.scroll-to-top').click((e)->
      e.preventDefault()
      $("html, body").animate({ scrollTop: 0 }, 600)
    )

    WisP.Router.start()

  masonry : () ->
    $container = $('.thermal-loop')
    gutter = 20
    min_width = 300
    $container.imagesLoaded(()->
      $container.masonry(
        itemSelector : '.thermal-item'
        gutterWidth: gutter
        isAnimated: true
        columnWidth: ( cWidth ) ->
          boxNum = (cWidth/min_width | 0)
          box_width = (((cWidth - (boxNum-1)*gutter)/boxNum) | 0)
          if cWidth < min_width then box_width = cWidth
          $('.thermal-item').width(box_width)
          return box_width
        )
    )

  getFeaturedImage : (id, images) ->
    q = _.where(images, {id: id})
    if q.length > 0
      if q[0].sizes
        if q[0].sizes[0].url
          return q[0]
    false

###
Format date object like "x minutes ago, y days ago, etc"

@moduel Date
@method timeAgo
###
Date.prototype.timeAgo = ()->
  date = new Date(this)
  diff = (((new Date()).getTime() - date.getTime()) / 1000)
  day_diff = Math.floor(diff / 86400)
  if isNaN(day_diff) or day_diff < 0 then return
  tAgo = (date.getMonth()+1) + ' ' + date.getDate() + ', ' + date.getFullYear()
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
