`import DS from 'ember-data';`

Room = DS.Model.extend
    organization: DS.belongsTo 'organization', async: true
    roster: DS.hasMany 'user', async: true
    messages: DS.hasMany 'message', async: true

    key: DS.attr()
    title: DS.attr()
    description: DS.attr()



`export default Room;`
