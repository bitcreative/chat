`import Ember from 'ember';`
`import DS from 'ember-data';`

ApplicationSerializer = DS.RESTSerializer.extend
    extractSingle: (store, primaryType, payload, id) ->
        data = {}
        data[primaryType.typeKey] = payload
        @_super store, primaryType, data, id

    extractArray: (store, primaryType, payload) ->
        name = Ember.String.pluralize primaryType.typeKey
        data = {}
        data[name] = payload
        @_super store, primaryType, data

`export default ApplicationSerializer;`
