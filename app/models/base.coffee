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
            return resolveObject cache[type][id]

        Organization = Parse.Object.extend 'Organization'
        query = new Parse.Query Organization

        PromiseObject.create
            promise: new Ember.RSVP.Promise (resolve, reject) =>
                query.get id,
                    success: =>
                        Array.prototype.splice.call arguments, 0, 0, type
                        resolve @createFromParse.apply(@, arguments)
                    error: reject

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
