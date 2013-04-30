window.WisP =
  config:
    baseUrl: ""
    per_page: 3
    html :
      categorySelect: $('#category-dropdown')
      main: $('#main')
      popup: $('#popup')

  init:()->
    $scrollToTop = $('.scroll-to-top')
    $(window).scroll(()->
      if $(this).scrollTop() > 100
        $scrollToTop.fadeIn()
      else
        $scrollToTop.fadeOut()
    )

    $scrollToTop.click((e)->
      e.preventDefault()
      $("html, body").animate({ scrollTop: 0 }, 600)
    )
    $('.dropdown-toggle').dropdown()
    WisP.masonry()

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
