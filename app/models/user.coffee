`import DS from 'ember-data'`
`import Ember from 'ember'`

User = DS.Model.extend
    firstName: DS.attr()
    lastName: DS.attr()
    email: DS.attr()

    organization: DS.belongsTo 'organization'
    messages: DS.hasMany 'messages', async: true

`export default User`
