ApplicationRoute = Ember.Route.extend
    actions:
        login: (username, password) ->
            @get('torii').open('api', {username, password}).then (data) =>
                @session.handleLogin data

        logout: () ->


        willTransition: (transition) ->
            if not @session.get 'authenticated'
                @session.set 'previousTransition', transition
                if transition.targetName not in ['register']
                    @transitionTo 'about'

    beforeModel: (transition) ->
        @session.authenticateWithToken (result) =>
            if not result
                if transition.targetName isnt 'index'
                    @session.set 'previousTransition', transition
                    @transitionTo 'about'

    watchForLogout: Ember.observer 'session.authenticated', ->
        if not @session.get 'authenticated'
            @transitionTo 'about'
        else
            @transitionTo 'dashboard'

`export default ApplicationRoute`
