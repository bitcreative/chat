unprotectedRoutes = ['register']

ApplicationRoute = Ember.Route.extend
    actions:
        willTransition: (transition) ->
            if not @session.get 'authenticated'
                @session.set 'previousTransition', transition
                if transition.targetName not in unprotectedRoutes
                    @transitionTo 'about'

    beforeModel: (transition) ->
        if not @session.get 'authenticated'
            if transition.targetName isnt 'index'
                @session.set 'previousTransition', transition

            promise = @session.get 'checkSessionPromise.promise'

            if promise
                promise.then (user) =>
                    previous = @session.get 'previousTransition'
                    target = previous?.targetName or if not user then 'about' else 'dashboard'

                    if previous then previous.retry() else @transitionTo target

                promise.catch =>
                    @transitionTo 'about'

            promise

    watchForLogout: Ember.observer 'session.authenticated', ->
        if not @session.get 'authenticated'
            @transitionTo 'about'

`export default ApplicationRoute`
