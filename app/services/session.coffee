Session = Ember.Object.extend
    firebase: null
    firebaseAuth: null

    user: null
    authPromise: null

    setupAuth: Ember.computed 'firebase', ->
        firebase = @get 'firebase'
        if firebase
            @firebaseAuth = new FirebaseSimpleLogin firebase, _.bind(@handleAuthenticationChange, @)

    authenticated: Ember.computed 'user', ->
        !!@get 'user'

    handleAuthenticationChange: (error, user) ->
        @set 'user', user
        promise = @clearPromise()
        if error
            promise.reject error

        else
            promise.resolve user

    login: (email, password) ->
        @authPromise ?= Ember.RSVP.defer()
        @firebaseAuth.login 'password', { email, password }
        @authPromise.promise

    register: (email, password) ->
        @authPromise ?= Ember.RSVP.defer()
        @firebaseAuth.createUser email, password, (error, user) =>
            if error
                @clearPromise().reject error

            else
                @login email, password

        @authPromise.promise

    logout: ->
        @firebaseAuth.logout()
        @clearPromise.reject "Logged Out"

    clearPromise: ->
        promise = @authPromise
        @authPromise = null

        promise or {
            resolve: -> null
            reject: -> null
        }

`export default Session`
