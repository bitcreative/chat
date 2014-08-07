`import { PromiseArray, PromiseObject } from '../utils/promises';`

resolveObject = (obj) ->
    PromiseObject.create
        promise: Ember.RSVP.resolve(obj)

ModelStore = Ember.Object.extend
    _types: []
    _cache: {}

    createRecord: (type, data, parse) ->
        @_storeType type
        modelClass  = @container.lookupFactory "model:#{type}"
        model = modelClass.create data

        model.set 'parse', parse
        model.set '_properties', Ember.keys data

        @_storeCache type, model
        @_loadRelations(model)

        model

    createFromParse: (type, parse) ->
        attributes = parse.attributes
        attributes.id = parse.id
        record = @createRecord type, attributes, parse

    find: (type, id) ->
        if _.isArray id
            @findAll type, id
        else
            @findById type, id

    findById: (type, id) ->
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

    findAll: (type, ids) ->
        promises = ids.map (id) =>
            @findById type, id

        PromiseArray.create
            promise: Ember.RSVP.all promises

    _loadRelations: (record) ->
        relations = record.get 'relations'
        record._properties.forEach (prop) =>
            value = record.get prop

            if value instanceof Parse.Relation
                relation = record.parse.relation(value.key)
                relation.query().find().then (models) =>
                    key = Ember.String.singularize prop
                    @find(key, models.mapBy 'id').then (results) ->
                        record.set prop, results

            else if prop in relations
                id = value.id
                record.set prop, @find(prop, id)


    _storeType: (type) ->
        types = @get '_types'
        types.addObject type

    _storeCache: (type, model) ->
        cache = @get '_cache'
        cache[type] = {} if not cache[type]
        id = model.get 'id'
        cache[type][id] = model if not cache[type][id]


BaseModel = Ember.Object.extend
    _properties: []

    relations: []

    save: () ->
        # save


`export var Store = ModelStore`;
`export default BaseModel;`
