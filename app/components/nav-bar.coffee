`import Ember from 'ember'`

NavBarComponent = Ember.Component.extend
    authenticatedBinding: 'session.authenticated'

    loginError: false
    passwordError: null
    usernameError: null

    passwordWarning: Ember.computed 'registrationPassword', 'passwordRepeat', ->
        password = @get 'registrationPassword'
        repeat = @get 'passwordRepeat'
        password and repeat and password isnt repeat

    hasFeedback: Ember.computed 'passwordWarning', 'passwordError', ->
        @get('passwordWarning') or @get('passwordError')

    focusFirstInput: ->
        @$('.first-input').focus()

    actions:
        openRegistrationModal: ->
            @set 'modalOpen', true
            Ember.run.scheduleOnce 'afterRender', @, @focusFirstInput

        closeRegistrationModal: ->
            @set 'modalOpen', false

        login: ->
            @set 'loginError', false
            username = @get 'loginUsername'
            password = @get 'loginPassword'

            @session.login username, password
                .then (user) =>
                    @set 'loginUsername', ''
                    @set 'loginPassword', ''
                    @sendAction 'loggedIn'

                .catch (error) =>
                    @set 'loginError', true
            return

        logout: ->
            @session.logout()
            @sendAction 'loggedOut'
            return

        register: ->
            @set 'passwordError', null
            @set 'usernameError', null

            username = @get 'registrationUsername'
            password = @get 'registrationPassword'
            passwordRepeat = @get 'passwordRepeat'

            if password isnt passwordRepeat
                @set 'passwordError', true
                @set 'registrationError', "<strong>Error!</strong> Password fields don't match"
                return

            @session.register username, password
                .then (user) =>
                    @set 'modalOpen', false
                    @sendAction 'loggedIn'

                .catch (error) =>
                    @set 'usernameError', true
                    @set 'registrationError', error
            return

`export default NavBarComponent`
