WisP.PostView = Backbone.View.extend

  initialize: () ->
    @template = WisP.Templates['post-full.html']

  render: () ->
    @parseGalleries() if @model.get('meta').gallery?
    @$el.html @template(@model.attributes)
    @replaceGalleries()
    headerPos = WisP.config.html.main.parent().offset().top
    $("html, body").animate({ scrollTop: headerPos }, 600)
    @

  parseGalleries: () ->
    content = @model.get 'content'
    matchIndex = 0
    _.each @model.get('meta').gallery, @addGallery, @
    galleryRegex = new RegExp /\[gallery(.+)\]/gm
    while matches = galleryRegex.exec content
      if @galleryViews.length < matchIndex
        return

      galleryID = 'replace-gallery-' + @model.get('id') + '-' + matchIndex
      galleryHTML = '<div id="' + galleryID + '"></div>'

      content = content.replace matches[0], galleryHTML
      matchIndex++
    if content isnt @model.get 'content'
      @model.set 'content', content

  replaceGalleries: () ->
    _.each @galleryViews, (view, idx) ->
      replace = 'div#replace-gallery-' + @model.get('id') + '-' + idx
      if @$el.find( replace ).is '*'
        gallery = view.render().el
        @$el.find( replace ).replaceWith gallery
    , @

  addGallery: (galleryData, idx) ->
    @galleryViews ?= []
    gallery = new WisP.Gallery

    _.each galleryData.ids, (id, i)->
      mediaItem = new WisP.Media id: id
      gallery.add mediaItem
    , @
    @galleryViews.push new WisP.GalleryView
      collection: gallery,
      postMedia: this.model.get('media')