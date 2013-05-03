WisP.GalleryView = Backbone.View.extend

  initialize: (opts) ->
    @template = WisP.Templates['gallery.html']
    @$el.html @template
    @postMedia = if opts? and opts.postMedia? then opts.postMedia else false
    @$inner = @$el.find '.carousel-inner'
    @galleryItemViews = []
    _.each @collection.models, (mediaItem, idx) ->
      @galleryItemViews.push new WisP.GalleryItemView
        model: mediaItem,
        postMedia: @postMedia
    , @
    @

  render: () ->
    @$inner.empty()

    _.each @galleryItemViews, (view, idx) ->
      @$inner.append view.render().el
    , @
    @