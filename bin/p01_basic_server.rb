require 'webrick'
require 'byebug'
server = WEBrick::HTTPServer.new(Port: 3000)

server.mount_proc("/") do |request, response|
  response.status = 302
  response["location"] = "http://google.com"
end

trap('INT') do
  server.shutdown
end

server.start

# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/HTTPRequest.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/HTTPResponse.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/Cookie.html
