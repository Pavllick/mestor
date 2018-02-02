require 'uri'
require 'net/http'
require 'socket'

# server = TCPServer.open 8000
client = nil

	# sleep 0.1

 #  client = server.accept    # Wait for a client to connect
 #  puts "Input connection................"
 #  client.puts "Hello !"
 #  client.puts "Time is #{Time.now}"
 #  # puts "Time is #{Time.now}"
 #  # sleep 0.2
	# line = client.recv(150)
	# puts line
	# line = client.recv(150)
	# puts line
	# # line = client.gets
	# # puts 'line.nil?'

 #  client.close

threads = []

self_uri = URI("http://localhost:8000")
server = TCPServer.new self_uri.port

threads << Thread.new do
	loop do
	  client = server.accept

	  attempts = 0
	  begin
	  	attempts += 1

		  req = client.recv(1000)
		  puts "\n" + '='*20 + ' Incoming request start ' + '='*20
		  puts 'HTTP Request length: ' + req.length.to_s
		  puts '='*60
		  puts req
		  puts '='*20 + ' Incoming request end ' + '='*20 + "\n"

		  client.puts 'HTTP/1.0 200 OK'
		rescue #IO::WaitReadable
		  #IO.select([client])
		  attempts < 40 ? retry : break

		end

	  client.close
	end
end

ror_uri = URI("http://localhost:3000")

threads << Thread.new do
	http_req_header = File.read('emulator/http.txt')
	loop do
		v = rand(10...30)
		http_req = http_req_header + "v=#{v}&s_n=DFG465DFG4"

		socket = TCPSocket.open(ror_uri.host, ror_uri.port)

		if socket
			puts "\n" + '*'*20 + ' Send device data ' + '*'*20  + "\n"
			socket.send http_req, 0
			puts http_req
			# puts "Closing the Client..................."
		end
		socket.close 

		sleep 4
	end
end

loop { sleep 1 }