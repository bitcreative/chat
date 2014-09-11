`import DS from 'ember-data';`

User = DS.Model.extend
    username: DS.attr()
    email: DS.attr()

    first_name: DS.attr()
    last_name: DS.attr()


`export default User`
