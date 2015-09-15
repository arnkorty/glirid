@app =
  init: ->
    @searches.init()
    $('.fdatetimepicker').fdatetimepicker({
      language: 'zh'
    })
    @ajaxBinding()
    @SyncStatus()

  ajaxBinding: ->
    $('a[data-method="delete"]').bind 'ajax:success', ->
      # console.log(this)
      tr = $(this).parent().parent()
      is_tr = false
      if tr.prop('tagName') == 'TR'
        is_tr = true
      tr = tr.parent() unless is_tr
      if tr.prop('tagName') == 'TR'
        is_tr = true
      if is_tr
        tr.hide('slow')
        tr.remove()
  accountId: ->
    $("body").data('account-id')
  SyncStatus: ->
    # sync = ->
    #   $.get '/sync_status', (data) ->
    #     status = $("#search-status-" + s.search_id)
    #       if status.length > 0
    #         status.attr('class', "search-status " + s.en_status)
    #         status.html(s.status)
    # #       console.log s
    # if @accountId()
    #   MessageBus.subscribe "/channel/" + @accountId(), (s) ->
    #     status = $("#search-status-" + s.search_id)
    #     if status.length > 0
    #       status.attr('class', "search-status " + s.en_status)
    #       status.html(s.status)
    #       console.log s
