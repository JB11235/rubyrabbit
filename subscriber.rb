#!/usr/bin/env ruby
require 'bunny'
require_relative './rabbit'

class Worker < RabbitLibrary #request and response for passed in url

  def build_request(payload)
  	req = JSON.parse(payload)
  	case req['verb']
  	when "GET"

  	when "POST"

  	when "PUT"
  	else
  	end
  end

end



client = Worker.new('my_task_queue')
client.channel.prefetch(1);

puts "[ ] worker started"

begin
  client.subscribe_to_queue do |d,prp,pay|
    puts " [√] #{pay}"
    return_message = "#{pay} == this is the return message"


	return_queue = Worker.new('return_task_queue')
    return_queue.publish_response(return_message)
	puts " [x] sent '#{return_message}'"
    return_queue.stop
  end
rescue Interrupt => _
  client.stop
  exit(0)
end
