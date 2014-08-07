ApplicationRoute = Ember.Route.extend
    actions:
        willTransition: (transition) ->
            if not @session.get 'authenticated'
                @session.set 'previousTransition', transition
                if transition.targetName not in ['register']
                    @transitionTo 'about'

    beforeModel: (transition) ->
        if not @session.get 'authenticated'
            if transition.targetName isnt 'index'
                @session.set 'previousTransition', transition
        else
            @transitionTo 'dashboard'
        return

    watchForLogout: Ember.observer 'session.authenticated', ->
        if not @session.get 'authenticated'
            @transitionTo 'about'
        else
            @transitionTo 'dashboard'

`export default ApplicationRoute`
