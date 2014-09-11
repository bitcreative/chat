`import Ember from 'ember';`

login = (username, password) ->
    Ember.$.post '/api/auth/login/', {username, password}

ApiAuthProvider = Ember.Object.extend
    open: (options) ->
        new Ember.RSVP.Promise (resolve, reject) =>
            username = options.username
            password = options.password

            login(username, password).then (data) =>
                resolve data

`export default ApiAuthProvider;`
