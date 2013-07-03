define [
  'jquery'
  'underscore'
  'backbone'
], ($, _, Backbone) ->

  _authenticated = false

  return new (class Session extends Backbone.Model
    url: '/me'

    initialize: () ->
      @login()

    login: () ->
      @fetch
        success: (model, response, options) =>
          if response.user_id
            # Logged in

            @set('user', response)

            _authenticated = true;
            @trigger('login')

        error: (model, response, options) ->
          console.log 'Failed to load session.'

    logout: () ->
      @reset()
      @clear()
      @trigger('logout')

    reset: () ->
      _authenticated = false
      @set('user', null)

    authenticated: () ->
      return _authenticated

    user: () ->
      return @get('user')
  )()
