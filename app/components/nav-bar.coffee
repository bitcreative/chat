`import Ember from 'ember'`

NavBarComponent = Ember.Component.extend
    authenticatedBinding: 'session.authenticated'

    loginError: false
    passwordError: null
    usernameError: null

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

`export default NavBarComponent`
