fs = require 'fs'
coffee = require 'coffee-script'
util = require 'util'
uglify = require 'uglify-js'
path = require 'path'
child_process = require('child_process')

src_folder = 'src/coffeescript'
javascript_folder = 'public/javascript'
src_compiled_folder = path.join(javascript_folder, 'compiled')
images_folder = 'public/img'
examples_folder = 'examples'

compile_folder = (input_folder, output_folder) ->
	output_folder = output_folder ? input_folder
	
	make_dir output_folder
	artifacts = fs.readdirSync(input_folder)
	artifacts = (item for item in artifacts when path.extname(item) is '.coffee')
	for item in artifacts
		input_file = path.join(input_folder, item)
		
		output_file_name = path.basename(item, '.coffee')
		output_file = path.join(output_folder, output_file_name + '.js')
		
		compile_file(input_file, output_file)
	

compile_file =  (input_file, output_file)->
	coffee_code = fs.readFileSync(input_file, encoding='utf8')

	js_code =  coffee.compile(coffee_code)

	fs.writeFile output_file, js_code, (error) ->
		if error
			throw error
		else
			util.log 'Built ' + output_file
			
make_dir = (folder_path) ->
	child_process.spawn('mkdir', ['-p', folder_path])

task 'build', 'Builds the project', ->
	util.log "Building #{src_folder}"

	compile_folder(src_folder, src_compiled_folder)

				
task 'build:examples', 'Prepares the examples.', ->
	invoke 'build:example1'
	invoke 'build:example2'
	
task 'build:example1', 'Prepares the example 1', ->
	util.log 'Building example 1'
	
	example1 = path.join(examples_folder, 'example1')
	
	child_process.spawn('cp', ['-r', images_folder, example1])
	child_process.spawn('cp', ['-r', javascript_folder, example1])
	
	util.log "Example 1 ready. Open #{example1}/index.html"
	
task 'build:example2', 'Prepares the example 2', ->
	util.log 'Building example 2'
	
	example2 = path.join(examples_folder, 'example2')
	
	server_side_folder = path.join(example2, 'server-side')
	compile_folder(server_side_folder)
	
	child_process.spawn('cp', ['-r', images_folder, example2])
	child_process.spawn('cp', ['-r', javascript_folder, example2])
	
	util.log "Example 2 ready.\nRun\n  cs #{example2}/server-side\n  node server.js\nand browse http://localhost:8080"	
	
task 'test', 'Executes the test server', ->
	util.log 'Running test server. Browse http://localhost:8124'
	child_process.spawn('jasmine', ['run'])
