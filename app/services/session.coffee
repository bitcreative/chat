Session = Ember.Object.extend
    firebase: null
    firebaseAuth: null

    user: null
    authPromise: null

    checkSessionPromise: null

    authenticated: Ember.computed 'user', ->
        !!@get 'user'

    setupAuth: Ember.observer 'firebase', ->
        firebase = @get 'firebase'
        if firebase
            @firebaseAuth = new FirebaseSimpleLogin firebase, _.bind(@handleAuthenticationChange, @)

            @set 'checkSessionPromise', Ember.RSVP.defer()

    handleAuthenticationChange: (error, user) ->
        @set 'user', user

        promise = @get('checkSessionPromise') or @clearPromise()
        @checkSessionPromise = null

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
        @firebaseAuth.createUser email, password, (error) =>
            if error
                @clearPromise().reject error

            else
                @login email, password

        @authPromise.promise

    logout: ->
        @firebaseAuth.logout()
        @clearPromise().reject "Logged Out"

    changePassword: (oldPassword, newPassword) -> new Ember.RSVP.Promise (resolve, reject) =>
        @firebaseAuth.changePassword @user?.email, oldPassword, newPassword, (error) ->
            if error
                reject error
            else
                resolve()

    clearPromise: ->
        promise = @authPromise
        @authPromise = null

        promise or {
            resolve: -> null
            reject: -> null
        }

`export default Session`
