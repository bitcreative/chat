`import Ember from 'ember';`

RoomController = Ember.Controller.extend
    actions:
        sendMessage: () ->
            message = @get 'message'
            messages = @get 'messages'
            if message
                @storeMessage message
                @sendMessageToChannel message
            return

    message: null
    messages: []

    establishChannelConnection: Ember.observer 'model', () ->
        model = @get 'model'
        channel = @get 'channel'
        if not channel
            channel = @connection.openChannel model.get('key')
            @set 'channel', channel

        @set 'messages', model.get('messages')

    attachMessageListener: Ember.observer 'channel', () ->
        channel = @get 'channel'
        channel.on 'message', (event) =>
            messages = @get 'messages'
            messages.pushObject event.data.payload.message

    storeMessage: (message) ->
        data =
            sender: @session.get 'user'
            room: @get 'model'
            text: message

        record = @store.createRecord 'message', data
        record.save()
        .then (record) =>
            console.log 'stored message'

    sendMessageToChannel: (message) ->
        channel = @get 'channel'
        channel.send 'message',
            message: message

        @messages.pushObject message
        @set 'message', ''

`export default RoomController;`
