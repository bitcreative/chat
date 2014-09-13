`import Ember from 'ember';`
`import DS from 'ember-data';`

ApplicationAdapter = DS.RESTAdapter.extend
    namespace: 'api'

    buildURL: (type, id, record) ->
        url = "#{@namespace}/#{type}/"
        if id
            url = "#{url}#{id}/"
        return url

`export default ApplicationAdapter;`
