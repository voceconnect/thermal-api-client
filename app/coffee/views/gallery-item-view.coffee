WisP.GalleryItemView = Backbone.View.extend

  initialize: (opts) ->
    @template = WisP.Templates['gallery-item.html']
    @className =  if opts? and
      opts.className? then "item" + opts.className else "item"
    @postMedia = if opts? and opts.postMedia? then opts.postMedia else false
    @model.set 'postMedia', @postMedia
    @render()

  render: (model) ->
    @$el.html @template(@model.attributes)
    @