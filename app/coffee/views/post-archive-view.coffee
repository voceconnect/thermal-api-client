WisP.PostArchiveView = Backbone.View.extend
  tagName: 'span'
  initialize: () ->
    @collection = WisP.Posts

  renderOne: (model) ->
    if model.get('meta').galleries?
      template = WisP.Templates[ 'gallery-excerpt.html' ]
    else
      template = WisP.Templates[ 'post-excerpt.html' ]
    @$el.append template(model.attributes)
    WisP.config.html.main.masonry('reload')
    @$el
