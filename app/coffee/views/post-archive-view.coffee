WisP.PostArchiveView = Backbone.View.extend
  tagName: 'span'
  initialize: () ->
    @collection = WisP.Posts

  renderOne: (model) ->
    template = WisP.Templates['post-excerpt.html']
    @$el.append(template(model.attributes))
    WisP.config.html.main.masonry('reload')
    @$el