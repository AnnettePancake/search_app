jQuery ->
  window.SearchDimensions = {}

  SearchDimensions.init = ->
    dimensions = $('.dimensions')
    error_messages = $('.error_messages')
    search_button = $('.search_button')

    $('.search_button').on 'click', ->
      search_button.prop 'disabled', true

      $('.progress').show()
      setTimeout(->
        $('.progress-bar').css
          'width': '99%'
          'transition': '10s'
      , 100)

      $.ajax
        type: 'POST',
        data: {
          term: $('.search #term').val()
        },
        url: 'search/find_dimensions',
        success:(response) ->
          $('.progress-bar').animate { 'width': '100%'}, 50
          error_messages.hide()
          dimensions.show()
          $('.dimensions .panel-body').text(response.message)
          search_button.prop 'disabled', false
          $('.progress').hide()
          $('.progress-bar').animate { 'width': '0%'}, 50
        error:(response) ->
          $('.progress-bar').animate { 'width': '100%'}, 50
          dimensions.hide()
          error_messages.show()
          $('.error_messages .panel-body').text(response.responseJSON.message)
          search_button.prop 'disabled', false
          $('.progress').hide()
          $('.progress-bar').animate { 'width': '0%'}, 50

    $('#term').on 'keypress', (e) ->
      $('.search_button').click() if e.keyCode == 13

  window.SearchDimensions.init();
