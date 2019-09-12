#!/usr/bin/env ruby
require 'bunny'
require 'httparty'
require 'json'
require 'pry'
require_relative './rabbit'


class MessageSender < RabbitLibrary
end
# QUEUE = 'my_task_queue'

client = MessageSender.new('my_task_queue')
client.call('GET', "https://randomuser.me/api/")
client.stop



