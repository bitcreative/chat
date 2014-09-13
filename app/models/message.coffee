`import DS from 'ember-data';`

Message = DS.Model.extend
    sender: DS.belongsTo 'user', async: true
    room: DS.belongsTo 'room', async: true

    text: DS.attr()

    date_sent: DS.attr()

`export default Message`
