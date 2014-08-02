Session = Ember.Object.extend
    firebase: null
    firebaseAuth: null

    user: null
    authPromise: null

    setupAuth: Ember.computed 'firebase', ->
        firebase = @get 'firebase'
        if firebase
            @set 'firebaseAuth', new FirebaseSimpleLogin firebase, _.bind(@handleAuthenticationChange, @)

    authenticated: Ember.computed 'user', ->
        !!@get 'user'

    handleAuthenticationChange: (error, user) ->
        Ember.Logger.info "Auth change: ", user, error
        @set 'user', user
        if @authPromise
            if error
                @authPromise.reject error
            else
                @authPromise.resolve user

`export default Session`
