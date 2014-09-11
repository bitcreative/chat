`import Ember from 'ember'`;

OrganizationRoom = Ember.Route.extend
    actions:
        error: (error, transition) ->
            if error and error.status is 404
                this.transitionTo 'organization.room', 'general'

    model: (params, transition) ->
        @store.find 'room', params.room_key


`export default OrganizationRoom;`
