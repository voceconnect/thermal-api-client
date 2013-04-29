WisP.PostView = Backbone.View.extend

  initialize: () ->
    @template = WisP.Templates['post-full.html']

  render: () ->
    @$el.html(@template(@model.attributes))