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
        Ember.Logger.info "Auth change: ", user, error
        @set 'user', user
        if @authPromise
            promise = @authPromise
            @authPromise = null

            if error
                promise.reject error
            else
                promise.resolve user

    login: (email, password) ->
        @authPromise ?= Ember.RSVP.defer()
        @firebaseAuth.login 'password', { email, password }
        @authPromise.promise

`export default Session`
