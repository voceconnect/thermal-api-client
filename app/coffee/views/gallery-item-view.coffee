WisP.GalleryItemView = Backbone.View.extend

  className: 'item'

  initialize: (opts) ->
    @template = WisP.Templates['gallery-item.html']
    @postMedia = if opts? and opts.postMedia? then opts.postMedia else false
    @model.set 'postMedia', @postMedia

  render: (model) ->
    @$el.html @template(@model.attributes)
    @