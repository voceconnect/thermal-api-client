WisP.Embed = class

  settings:
    elSelector: '#wisp-embed'
    apiUrl: ''
    method : 'showPosts'

  constructor: (opts) ->
    @settings = $.extend(@settings, opts)
    $(document).ready(()=>
      @settings.$el = $(@settings.elSelector)
      @embedHTMLels()
      @embedStyles()
      WisP.config.baseUrl = @settings.apiUrl
      WisP.config.html =
        categorySelect: @settings.$el.find('#category-dropdown')
        main: @settings.$el.find('#main')
        popup: @settings.$el.find('#popup')
      WisP.init()
      eval("WisP.Controller.#{@settings.method}")
      WisP.Controller.showCategoriesMenu()
    )

  embedHTMLels: ()->
    htmlEls = """
    <div id="category-dropdown"></div>
    <div id="main"></div>
    <div id="popup" class="modal hide fade"></div>
    """
    @settings.$el.append($(htmlEls))

  embedStyles: ()->
    wispLibURL = $('#wispLib').attr('src').split('/js/wisp.js')
    if wispLibURL and wispLibURL[0]
      styleEl = """
                <link type='text/css' rel='stylesheet'
                href='#{wispLibURL[0]}/css/wisp.css'>
                """
      @settings.$el.append($(styleEl))