`import Ember from 'ember';`

loginWithToken = (token) ->
    Ember.$.post '/api/auth/login/', {token}

SessionService = Ember.Object.extend
    user: null

    authenticated: Ember.computed 'user', ->
        !!@get 'user'

    setAuthorizationHeader: Ember.on 'init', () ->
        token = Ember.$.cookie 'sessionToken'
        if token
            Ember.$.ajaxSetup
                headers:
                    Authorization: "Token #{token}"

    authenticateWithToken: () ->
        token = Ember.$.cookie 'sessionToken'
        new Ember.RSVP.Promise (resolve) =>
            if not token
                resolve false

            loginWithToken(token).then (data) =>
                @handleLogin data
                resolve data

    handleLogin: (data) ->
        sessionToken = data.token
        Ember.$.cookie 'sessionToken', sessionToken

        if @get 'user'
            return

        user = @store.createRecord 'user', data.user
        @set 'user', user

    register: (username, password, email) ->
        user.set 'username', username
        user.set 'password', password
        user.set 'email', email ;

        new Ember.RSVP.Promise (resolve, reject) =>

    logout: ->
        @set 'user', null


`export default SessionService`
