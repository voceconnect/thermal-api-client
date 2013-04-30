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