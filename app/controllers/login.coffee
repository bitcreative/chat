`import Ember from 'ember'`

LoginController = Ember.Controller.extend
    loginError: false

    action:
        login: ->
            @set 'loginError', false

            email = @get 'email'
            password = @get 'password'

            if not email or not password
                @set 'loginError', true
            else
                @session.login email, password
                    .then =>
                        @transitionToRoute 'index'
                    .catch =>
                        @set 'loginError', true

`export default LoginController`