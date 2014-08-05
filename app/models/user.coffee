`import DS from 'ember-data'`
`import Ember from 'ember'`

User = DS.Model.extend
    firstName: DS.attr()
    lastName: DS.attr()
    email: DS.attr()

    messages: DS.hasMany 'messages'

`export default User`
