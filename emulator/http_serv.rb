require 'uri'
require 'net/http'
require 'socket'

# server = TCPServer.open 8000
# client = nil

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

# @temperature_set = 0
# @alarm = 0
# @work_state = 0

@temperature_set = :temperature_set
@alarm = :alarm
@work_state = :work_state

data = Hash.new
data_old = Hash.new

data[@temperature_set] = 0
data[@alarm] = 0
data[@work_state] = 0

mode = "w"

if !File.file?("prom_boiler.txt")
	File.open("prom_boiler.txt", mode) do |f|
		f.write("#{@temperature_set}#{data[@temperature_set]}\n")
		f.write("#{@alarm}#{data[@alarm]}\n")
		f.write("#{@work_state}#{data[@work_state]}")
	end
end

IO.foreach("prom_boiler.txt") do |l|
	# print l

	name = l.chomp[/(\D){1,}/]
	data[name.to_sym] = /\d+/.match(l.chomp).to_s.to_i
end

# Local Server
self_uri = URI("http://localhost:8000")
server = TCPServer.new self_uri.port
threads << Thread.new do
	loop do
	  client = server.accept

	  attempts = 0
	  begin
	  	attempts += 1

		  req = client.recv(1000)
		  client.puts 'HTTP/1.0 200 OK'
		  client.close

		  puts "\n" + '='*20 + ' Incoming request start ' + '='*20
		  puts 'HTTP Request length: ' + req.length.to_s
		  puts '='*60
		  puts req
		  puts '='*20 + ' Incoming request end ' + '='*20 + "\n"

		  val = req[/data=(\d)+/][/\d+/]
		  data[@temperature_set] = val.to_s.to_i if val
		rescue #IO::WaitReadable
		  #IO.select([client])
		  attempts < 40 ? retry : break

		end

	  # client.close if client
	end
end

# Client with sensors
ror_uri = URI("http://localhost:3000")
threads << Thread.new do
	http_req_header = File.read('http.txt')
	loop do
		rand_low = data[@temperature_set] - 4
		rand_high = data[@temperature_set] + 4
		v = rand(rand_low...rand_high)
		http_req = http_req_header + "v=#{v}&s_n=DFG465DFG4"

		socket = TCPSocket.open(ror_uri.host, ror_uri.port)

		if socket
			puts "\n" + '*'*20 + ' Send device data ' + '*'*20  + "\n"
			socket.send http_req, 0
			# puts http_req
			# puts '='*20 + ' Send device data end ' + '='*20 + "\n"
		end
		socket.close 

		sleep 2
	end
end


threads << Thread.new do
	loop do
		puts data[@temperature_set]
		if data != data_old
			file = File.open("prom_boiler.txt", mode)
			file.truncate file.size

			file.write("#{@temperature_set}#{data[@temperature_set]}\n")
			file.write("#{@alarm}#{data[@alarm]}\n")
			file.write("#{@work_state}#{data[@work_state]}")

			file.close

			data_old = data
		end

		sleep 4

		puts data.inspect
	end
end

puts 'Enter for quit'
exit = gets
threads.each { |th| th.join(2) }
puts "Exit"