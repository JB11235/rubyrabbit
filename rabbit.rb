#!/usr/bin/env ruby
require 'bunny'
require 'httparty'
require 'json'
require 'pry'

class RabbitLibrary
  
  attr_reader :channel, :queue

  def initialize(task_queue)
  	@connection = Bunny.new
	@connection.start
	@channel = @connection.create_channel
	@queue = @channel.queue(task_queue, durable: true)
  end

  def request_url(verb, url, message="", headers="")
  	request = {verb: verb, url: url, message: message, headers: "" }.to_json
  	@queue.publish(request.to_s)
  end

  def publish_response(r)
  	@queue.publish(r.to_s)
  end

  def 

  def stop
    @channel.close
    @connection.close
  end

  def subscribe_to_queue(&block)
    @queue.subscribe(block: true, manual_ack: true) do |delivery_info, properties, payload|
      block.call(delivery_info, properties, payload)
      @channel.ack(delivery_info.delivery_tag)    
	end
  end
end