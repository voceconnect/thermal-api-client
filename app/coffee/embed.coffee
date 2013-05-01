WisP.Embed = class

  settings:
    elSelector: '#wisp-embed'
    baseUrl: ''

  constructor: (opts) ->
    @settings = $.extend(@settings, opts)
    $(document).ready(()=>
      @settings.$el = $(@settings.elSelector)
      @embedHTMLels()
      @embedStyles()
      WisP.config.baseUrl = @settings.baseUrl
      WisP.config.html =
        categorySelect: @settings.$el.find('#category-dropdown')
        main: @settings.$el.find('#main')
        popup: @settings.$el.find('#popup')
      WisP.init()
    )

  embedHTMLels: ()->
    htmlEls = """
    <div id="category-dropdown"></div>
    <div id="main"></div>
    <div id="popup"></div>
    """
    @settings.$el.append($(htmlEls))

  embedStyles: ()->
    styleEl = "<link type='text/css' rel='stylesheet' href='css/wisp.css>"
    @settings.$el.append($(styleEl))