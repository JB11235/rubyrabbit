#!/usr/bin/env ruby
require 'bunny'
require 'pry'
require_relative './rabbit'

class ReturnQueue < RabbitLibrary
end

client = ReturnQueue.new('return_task_queue')
client.channel.prefetch(1);

puts "[ ] return_queue started"
begin
  client.subscribe_to_queue do |d,prp,pay|
  	puts "[√] here is the delivery info #{d}"
  	puts "[√] here is the properties #{prp}"
  	puts "[√] here is the  #{pay}"
  end
rescue Interrupt => _
  client.stop
  exit(0)
end


