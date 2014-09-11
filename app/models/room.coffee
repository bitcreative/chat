`import DS from 'ember-data';`

Room = DS.Model.extend
    organization: DS.belongsTo 'organization', async: true
    key: DS.attr()
    title: DS.attr()
    description: DS.attr()
    roster: DS.hasMany 'user', async: true


`export default Room;`
