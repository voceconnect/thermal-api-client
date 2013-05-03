WisP.Posts = Backbone.Collection.extend

  initialize: (models, options) ->
    @model = WisP.Post
    @paged = if options? and options.paged? then options.paged else 1
    @per_page = WisP.config.per_page
    baseUrl = WisP.config.baseUrl
    @url = "#{baseUrl}/posts/"
    params =
      per_page: @per_page
      paged: @paged
      include_found: 1
    if options? and options.category?
      @category = options.category
      params.cat = options.category
    ​query = $.param(params)
    @url = "#{@url}?#{query}"

  parse: (response)->
    @found = response.found
    response.posts

