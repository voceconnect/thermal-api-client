WisP.Posts = Backbone.Collection.extend

  initialize: (models, options) ->
    @model = WisP.Post
    @paged = if options? and options.paged? then options.paged else 1
    @per_page = WisP.config.per_page
    baseUrl = WisP.config.baseUrl
    @url =  "#{baseUrl}/posts/?per_page=#{@per_page}&paged=#{@paged}"
    if options? and options.category?
      @url = @url+'&cat='+options.category

  parse: (response)->
    @found = response.found
    response.posts

