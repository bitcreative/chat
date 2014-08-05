User = DS.Model.extend
    firstName: DS.attr()
    lastName: DS.attr()
    email: DS.attr()

    messages: DS.hasMany 'messages'
