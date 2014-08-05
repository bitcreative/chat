`import Ember from 'ember'`

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
                    target = previous?.targetName
                    if user is null
                        target ?= 'about'
                    else
                        target ?= 'dashboard'

                    if previous then previous.retry() else @transitionTo target
                .catch () =>
                    @transitionTo 'about'

            promise

    watchForLogout: Ember.observer 'session.authenticated', ->
        if @session.get 'authenticated'
            previous = @session.get 'previousTransition'
            @transitionTo 'dashboard'
        else
            @transitionTo 'about'

`export default ApplicationRoute`
