WisP.GalleryItemView = Backbone.View.extend

  initialize: () ->
    @template = WisP.Templates['gallery-item.html']
    @className =  if opts? and
      opts.className? then "item" + opts.className else "item"
    @render()

  render: (model) ->
    @$el.html @template(@model.attributes)
    @