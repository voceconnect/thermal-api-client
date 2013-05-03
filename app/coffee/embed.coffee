WisP.Embed = class

  settings:
    elSelector: '#wisp-embed'
    apiUrl: ''
    perPage: 3
    method : 'showPosts()'

  constructor: (opts) ->
    @settings = $.extend(@settings, opts)
    $(document).ready(()=>
      @settings.$el = $(@settings.elSelector)
      @embedHTMLels()
      @embedStyles()
      WisP.config.baseUrl = @settings.apiUrl
      WisP.config.per_page = @settings.perPage
      WisP.config.html =
        categorySelect: @settings.$el.find('#category-dropdown')
        main: @settings.$el.find('#main')
        popup: $('#wisp-popup')
      WisP.init()
      try
        eval("WisP.Controller.#{@settings.method}")
      catch e
        console.log e
      WisP.Controller.showCategoriesMenu()
    )

  embedHTMLels: ()->
    htmlEls = """
    <div class="wisp">
    <div class="container">
    <div id="category-dropdown"></div>
    <div class="thermal-loop" id="main"></div>
    </div>
    </div>
    """
    @settings.$el.append($(htmlEls))
    popup = """
            <div id="wisp-popup" class="modal hide fade"></div>
            """
    $('body').append($(popup))
    $('html').addClass('wisp-modal')

  embedStyles: ()->
    wispLibURL = $('#wispLib').attr('src').split('/js/wisp.js')
    if wispLibURL and wispLibURL[0]
      styleEl = """
                <link type='text/css' rel='stylesheet'
                href='#{wispLibURL[0]}/css/wisp.css'>
                """
      @settings.$el.append($(styleEl))