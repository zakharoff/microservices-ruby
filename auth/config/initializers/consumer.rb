channel = RabbitMq.consumer_channel
exchange = channel.default_exchange
queue = channel.queue('auth', durable: true)

queue.subscribe(manual_ack: true) do |delivery_info, properties, payload|
  Thread.current[:request_id] = properties.headers['request_id']

  payload = JSON(payload)
  uuid = begin
           JwtEncoder.decode(payload['token'])['uuid']
         rescue StandardError
           ''
         end

  result = Auth::FetchUserService.call(uuid)
  response = result.success? ? { user_id: result.user.id } : ''

  Application.logger.info(
    'authentication requested',
    response,
    success: result.success?
  )

  exchange.publish(
    response.to_json,
    correlation_id: properties.correlation_id,
    routing_key: properties.reply_to,
    headers: {
      request_id: properties.headers['request_id']
    }
  )

  channel.ack(delivery_info.delivery_tag)
end
