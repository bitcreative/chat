ManageOrganization = Ember.Controller.extend
    owners: Ember.computed 'model.owners', ->
        @get 'model.owners'


`export default ManageOrganization;`
