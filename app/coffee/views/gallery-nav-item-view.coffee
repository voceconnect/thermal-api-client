WisP.GalleryNavItemView = Backbone.View.extend

  tagName: 'li'

  events:
    'click a': 'slideTo'

  initialize: (opts) ->
    @template = WisP.Templates['gallery-thumbnail-nav-item.html']
    @postMedia = if opts? and opts.postMedia? then opts.postMedia else false
    @model.set 'postMedia', @postMedia


  render: (model) ->
    @$el.html @template(@model.attributes)
    @

  slideTo: (e) ->
    @$el.trigger "slideTo", [$(e.target).parents(@tagName).index()]