WisP.PostArchiveView = Backbone.View.extend

  initialize: () ->
    @collection = WisP.Posts
    #@listenTo(@collection, 'add', @renderOne)

  renderOne: (model) ->
    template = WisP.Templates['post-excerpt.html']
    @$el.append(template(model.attributes))