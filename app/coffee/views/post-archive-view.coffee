WisP.PostArchiveView = Backbone.View.extend

  initialize: () ->
    @collection = WisP.Posts

  renderOne: (model) ->
    template = WisP.Templates['post-excerpt.html']
    @$el.append(template(model.attributes))