`import Ember from 'ember';`

RoomController = Ember.Controller.extend
    actions:
        sendMessage: () ->
            message = @get 'message'
            messages = @get 'messages'
            if message
                @storeMessage message
            return

    message: null

    establishChannelConnection: Ember.observer 'model', () ->
        model = @get 'model'
        channel = @get 'channel'
        if not channel
            channel = @connection.openChannel model.get('key')
            @set 'channel', channel

    attachMessageListener: Ember.observer 'channel', () ->
        channel = @get 'channel'
        channel.on 'message', (event) =>
            id = event.data.payload.id
            @store.find 'message', id

    storeMessage: (message) ->
        sender = @session.get 'user'
        room = @get 'model'

        data =
            sender: sender
            room: room
            text: message

        record = @store.createRecord 'message', data

        # get around belongsTo issues
        record.set '_extra',
            sender: sender
            room: room

        record.save()
        .then (record) =>
            @sendMessageToChannel record

    sendMessageToChannel: (record) ->
        channel = @get 'channel'
        channel.send 'message',
            record.toJSON(includeId: true)

        @set 'message', ''

`export default RoomController;`
