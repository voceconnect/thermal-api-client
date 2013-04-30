WisP.Post = Backbone.Model.extend

  defaults:
    id: 0
    author:
      id: 0
      display_name: ""
      postsUrl: ""
      userUrl: ""
      avatar:[
        url: ""
        width: 0
        height: 0
      ]
    date: ""
    permalink: ""
    title: "Default Post Title"
    content: ""
    media: ""
    excerpt: ""

  initialize: ( atts, options ) ->

  urlRoot: () =>
    "#{WisP.config.baseUrl}/posts/"