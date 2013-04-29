WisP.Post = Backbone.Model.extend

  defaults:
    author:
      id: 0
      display_name: ""
      postsUrl: ""
      userUrl: ""
      avatar:
        url: ""
        width: 0
        height: 0
    date: ""
    permalink: ""
    title: ""
    content: ""
    media: ""

  initialize: ( id ) ->
    @set(id: id)

  url: () ->
    baseUrl + "posts" + @get(id)