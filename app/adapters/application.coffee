`import Ember from 'ember';`
`import DS from 'ember-data';`

ApplicationAdapter = DS.RESTAdapter.extend
    namespace: 'api'

    pathForType: (type) ->
        main = Ember.String.decamelize(type)
        if type not in ['organization', 'room', 'message']
            main += '/'
        return main

`export default ApplicationAdapter;`
