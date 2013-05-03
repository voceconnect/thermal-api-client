WisP.Gallery = Backbone.Collection.extend

  initialize: (opts) ->
    @model = WisP.Media
    @postMedia = if opts? and opts.post? then opts.post.get('media') else false