`import Ember from 'ember';`

RoomController = Ember.Controller.extend
    actions:
        sendMessage: () ->
            message = @get 'message'
            messages = @get 'messages'
            if message
                channel = @get 'channel'
                channel.send 'message',
                    message: message

                @messages.pushObject message
                @set 'message', ''
            return

    message: null
    messages: []

    establishChannelConnection: Ember.observer 'model', () ->
        model = @get 'model'
        channel = @get 'channel'
        if not channel
            channel = @connection.openChannel model.get('key')
            @set 'channel', channel

    attachMessageListener: Ember.observer 'channel', () ->
        channel = @get 'channel'
        channel.on 'message', (event) =>
            messages = @get 'messages'
            messages.pushObject event.data.payload.message

`export default RoomController;`
