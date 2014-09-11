`import Ember from 'ember'`

NavBarComponent = Ember.Component.extend
    authenticatedBinding: 'session.authenticated'

    loginError: false

    login:
        username: null
        password: null

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
            login = @get 'login'

            if not login.username or not login.password
                @set 'loginError', true
                return

            @triggerAction
                action: 'login'
                actionContext: [login.username, login.password]

        logout: ->
            @session.logout()
            @sendAction 'loggedOut'
            return

`export default NavBarComponent`
