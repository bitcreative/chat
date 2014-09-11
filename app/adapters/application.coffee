`import Ember from 'ember';`
`import DS from 'ember-data';`

ApplicationAdapter = DS.RESTAdapter.extend
    namespace: 'api'

    pathForType: (type) ->
        Ember.String.decamelize(type)

`export default ApplicationAdapter;`
