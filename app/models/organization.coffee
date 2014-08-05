Organization = DS.Model.extend
    name: DS.attr()
    owner: DS.attr()
    
    users: DS.hasMany 'user', async: true
    rooms: DS.hasMany 'rooms', async: true

`export default Organization`
