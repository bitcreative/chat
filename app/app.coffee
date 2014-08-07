`import Ember from 'ember'`
`import Resolver from 'ember/resolver'`
`import loadInitializers from 'ember/load-initializers'`

Ember.MODEL_FACTORY_INJECTIONS = true

App = Ember.Application.extend {
    modulePrefix: 'chat'
    Resolver: Resolver
}

loadInitializers App, 'chat'

`export default App`
