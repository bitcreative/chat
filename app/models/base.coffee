`import { PromiseArray, PromiseObject } from '../utils/promises';`

resolveObject = (obj) ->
    PromiseObject.create
        promise: Ember.RSVP.resolve(obj)

ModelStore = Ember.Object.extend
    _types: []
    _cache: {}

    createRecord: (type, data) ->
        @_storeType type
        modelClass  = @container.lookupFactory "model:#{type}"
        model = modelClass.create data
        @_storeCache type, model
        model

    createFromParse: (type, parse) ->
        attributes = parse.attributes
        attributes.id = parse.id
        @createRecord type, attributes

    find: (type, id) ->
        cache = @get '_cache'
        if cache[type]?[id]
            return resolveObject(cache[type][id])
        new Error 'LOL THERE IS NO INTERNET LOADING, SUCKER'

    _storeType: (type) ->
        types = @get '_types'
        types.addObject type

    _storeCache: (type, model) ->
        cache = @get '_cache'
        cache[type] = {} if not cache[type]
        id = model.get 'id'
        cache[type][id] = model if not cache[type][id]


BaseModel = Ember.Object.extend
    save: () ->
        # save


`export var Store = ModelStore`;
`export default BaseModel;`
