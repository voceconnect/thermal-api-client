WisP.GalleryView = Backbone.View.extend

  initialize: () ->
    @template = WisP.Templates['gallery.html']
    @$el.html @template
    @$inner = @$el.find '.carousel-inner'
    @galleryItemViews = []
    _.each @collection.models, (mediaItem, idx) ->
      @galleryItemViews.push new WisP.GalleryItemView
        model: mediaItem
    , @
    @

  render: () ->
    @$inner.empty()

    _.each @galleryItemViews, (view, idx) ->
      @$inner.append view.render().el
    , @
    @