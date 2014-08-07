ManageOrganization = Ember.Route.extend
    model: () ->
        @session.get 'user.organization'

`export default ManageOrganization;`
