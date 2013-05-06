WisP.GalleryView = Backbone.View.extend

  className: 'carousel-container'

  events:
    'click a.carousel-control' : 'slide',
    'mouseover a.thumbs-scroll' : 'scrollThumbs',
    'mouseout a.thumbs-scroll' : 'stopScrollThumbs',
    'click a.thumbs-scroll' : 'fastScrollThumbs',
    'slideTo' : 'slideTo'

  initialize: (opts) ->
    @template = WisP.Templates['gallery.html']
    @$el.html @template
    @delegateEvents(@events)
    @postMedia = if opts? and opts.postMedia? then opts.postMedia else false
    @$carousel = @$el.find '.carousel'
    @$inner = @$carousel.find '.carousel-inner'
    @$nav = @$carousel.find '.carousel-indicators',
    @galleryItemViews = []
    @galleryNavItemViews = []
    _.each @collection.models, (mediaItem, idx) ->
      @galleryItemViews.push new WisP.GalleryItemView
        model: mediaItem,
        postMedia: @postMedia
      @galleryNavItemViews.push new WisP.GalleryNavItemView
        model: mediaItem,
        postMedia: @postMedia
    , @
    @

  render: () ->
    @$inner.empty()

    _.each @galleryItemViews, (view, idx) ->
      @$inner.append view.render().el
    , @
    _.each @galleryNavItemViews, (navView, idx) ->
      navItem = navView.render().el
      $(navItem).find('a').data('slide-to', idx)
      @$nav.append navItem
    , @
    @$nav.width( @$nav.find( 'li' ).length * 106 )
    @$inner.find('.item').first().addClass 'active'
    @$carousel.carousel()
    @

  slide: (e) ->
    dir = if $(e.target).hasClass 'left' then 'prev' else 'next'
    @$carousel.carousel dir

  slideTo: (e, idx)->
    @$carousel.carousel idx

  scrollThumbs: (e)->
    if $(e.target).hasClass 'left'
      scrollVal = 0
    else
      scrollVal = -( @$nav.width() - @$nav.parent().width() )
    @$nav.animate { left: scrollVal }, 3000

  stopScrollThumbs: (e)->
    @$nav.stop()

  fastScrollThumbs: (e)->
    e.stopImmediatePropagation()
    @$nav.stop()
    maxScroll = -( @$nav.width() - @$nav.parent().width() )
    currentLeft = parseFloat @$nav.css('left')

    scrollVal = if $(e.target).hasClass 'left' then 300 else -300
    scrollVal = currentLeft + scrollVal

    #scroll is negative
    if scrollVal < maxScroll
      scrollVal = maxScroll
    else if scrollVal > 0
      scrollVal = 0
    @$nav.animate { left: scrollVal }, 300