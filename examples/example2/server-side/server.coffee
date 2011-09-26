http = require 'http'
fs = require 'fs'
path = require 'path'
url = require 'url'


http.createServer((request, response) ->
	console.log 'Requested ' + request.url
	
	String::startsWith = (prefix) ->
		@indexOf(prefix) == 0	
	
	if request.url.startsWith('/record_popup_close')
		parsed = url.parse(request.url, parseQueryString=true)
		user_id = parsed.query.user_id
		message_id = parsed.query.message_id
		response.writeHead(200)
		response.end()
		console.log "User #{user_id} closed the popup with the message #{message_id}"
	else
		file_path = '..' + request.url
		if file_path is '../'
			file_path = '../index.html'
		
		extension = path.extname file_path
		content_type = 'text/html'
		switch extension
			when '.js'
				content_type = 'text/javascript'
			when '.css'
				content_type = 'text/css'
			when '.png'
				content_type = 'image/png'
			when '.jpg', '.jpeg'
				content_type = 'image/jpeg'

		console.log file_path
		path.exists(file_path, (exists) ->
			if exists
				fs.readFile(file_path, (error, content) ->
					if error
						response.writeHead 500
						response.end()			
					else 
						response.writeHead(200, {'Content-Type' : content_type})
						response.end(content, 'utf-8')
					)
			else
				response.writeHead(404)
				response.end()
		)
).listen(8080)

console.log 'Server started visit http://127.0.0.1:8080'