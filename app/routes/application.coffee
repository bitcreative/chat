ApplicationRoute = Ember.Route.extend
    actions:
        login: (username, password) ->
            @get('torii').open('api', {username, password})
            .then (data) =>
                @session.handleLogin data
                @transitionTo 'dashboard'
            .catch (data) =>
                console.log 'login error'

        logout: () ->


        willTransition: (transition) ->
            if not @session.get 'authenticated'
                @session.set 'previousTransition', transition
                if transition.targetName not in ['register']
                    @transitionTo 'about'

    beforeModel: (transition) ->
        @session.authenticateWithToken().then (result) =>
            if not result
                if transition.targetName isnt 'index'
                    @session.set 'previousTransition', transition
                    @transitionTo 'login'

    watchForLogout: Ember.observer 'session.authenticated', ->
        if not @session.get 'authenticated'
            @transitionTo 'about'
        else
            @transitionTo 'dashboard'

`export default ApplicationRoute`
