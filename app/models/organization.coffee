`import DS from 'ember-data';`

Organization = DS.Model.extend
    name: DS.attr()

    users: DS.hasMany 'user', async: true
    rooms: DS.hasMany 'rooms', async: true

    owners: Ember.computed 'users', () ->
        users = @get 'users'
        users.filterBy? 'isOwner'

`export default Organization`
