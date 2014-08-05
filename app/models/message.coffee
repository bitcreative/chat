`import DS from 'ember-data'`
`import Ember from 'ember'`

Message = DS.Model.extend
    user: DS.belongsTo 'user'
    room: DS.belongsTo 'room'

    text: DS.attr()
    timestamp: DS.attr()

`export default Message`
