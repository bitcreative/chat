`import UserModel from '../models/user';`

Session = Ember.Object.extend
    firebase: null
    firebaseAuth: null

    user: null
    authPromise: null

    checkSessionPromise: null

    authenticated: Ember.computed 'user', ->
        !!@get 'user'

    setUserFromSession: Ember.on 'init', ->
        currentUser = Parse.User.current()
        if currentUser
            @set 'user', @store.createFromParse 'user', currentUser

    login: (username, password) ->
         new Ember.RSVP.Promise (resolve, reject) =>
            Parse.User.logIn username, password,
                success: (user) =>
                    @handleLogin user
                    resolve user
                error: (user, error) ->
                    reject user, error
            return

    handleLogin: (user) ->
        sessionToken = user._sessionToken
        $.cookie 'sessionToken', sessionToken

        @store.createFromParse 'user', user

    register: (username, password, email) ->
        user = new Parse.User()
        user.set('username', username)
        user.set('password', password)
        user.set('email', email);

        new Ember.RSVP.Promise (resolve, reject) =>
            user.signUp null,
                success: (user) =>
                    @handleLogin user
                    resolve user
                error: (user, error) ->
                    reject user, error
            return

    logout: ->
        @set 'user', null

        Parse.User.logOut()

    changePassword: (oldPassword, newPassword) -> new Ember.RSVP.Promise (resolve, reject) =>
        @firebaseAuth.changePassword @user?.email, oldPassword, newPassword, (error) ->
            if error
                reject error
            else
                resolve()


`export default Session`
