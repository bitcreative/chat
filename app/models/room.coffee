Room = DS.Model.extend
    name: DS.attr()
    title: DS.attr()

    messages: DS.hasMany 'message'

`export default Room`
