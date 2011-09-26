Popapp
=====
An easy to use and highly customizable modal popup for the web.

Features
-----
* Highly customizable
* Auto resize
* No need of css files
* Get notified when a user dismisses a Popapp

Build and installation
-----
Clone the repository
<pre><code>git clone git://github.com/luisobo/Popapp.git
cd Popapp</code></pre>
Build the javascript
<pre><code>cake build</code></pre>

Copy the files to your public dir:
<pre><code>cp -r public/javascript your/public/dir
cp -r public/img your/public/dir</code></pre>  

Import the javascript in you html file:
<pre><code>&lt;script src="javascript/compiled/Popapp.js" type="text/javascript" charset="utf-8"&gt;&lt;/script&gt;</code></pre>

Basic Usage
-----
Create a new Popapp:
<pre><code>popapp = new Popapp</code></pre>
Set the contents:
<pre><code>popapp.content '&lt;div>Hello! I'm a Popupp!&lt;/div>'</code></pre>
Show the popapp:
<pre><code>popapp.show()</code></pre>

Decorators
-----
Subclass `PopappDecorator` and customize each part of your Popapps! Create new class that pack the customization in a reusable way. Popapp comes with a few:  

* `RoundCornersCss3` -- round corners
* `ShadowCss3` -- drop shadow
* `InnerShadowCss3` -- inner shadow

Each Decorator has its own parameters, so the final look of your Popapp it's up to you!

<b>Example:</b>  
Instantiate the decorator you want to use:
<pre><code>corners = new RoundCornersCss3 '25px'
shadow = new ShadowCss3
inner_shadow = new InnerShadowCss3'</code></pre>

and just make them decorate your Popapp:
<pre><code>popapp.decorate(corners, shadow, inner_shadow)</code></pre>

For customizing a Decorator just set its properties after the instantiation:
<pre><code>shadow = new ShadowCss3
	.vertical_offset('25px')
	.horizontal_offet('25px')
	.color('blue')
	.spread('15px')
	.blur('5px)
	
popapp.decorate(shadow)</code></pre>

###Creating your own Decorator###
You need to subclass `PopappDecorator` and override these methods:
<pre><code>decorate_popup: (popup)
decorate_close_button: (close_button)
decorate_background: (background)
decorate_content: (content)
</code></pre>
each method receive the jQuery element that represents a part of a Popapp

Close handlers
-----
You can be notified when a Popapp is dismissed. You will be able to take actions when a user close a Popapp.

For instance, you can keep track of which users dimissed a certain message.  
<b>Example:</b>
<pre><code>popapp.on_close (popapp) ->
	#Get the user id from the cookies
	user_id = get_user_id()
	
	#Get the message id from the Popapp
	message_id = popapp.message_id()
	
	#Form the url for the request
	url = "url/of/the/request?user_id=#{user_id}&message_id=#{message_id}"
	
	#Make an ajax request to store the info
	$.post(url)
</code></pre>

The message id is passed to the Popapp alogn with the contents of the message:
<pre><code>popapp.contents '&lt;div>Welcome to my Webapp!&lt;/div>', 'welcome_msg'</code></pre>

Examples
----
<b>Building the examples</b>  
It's as easy as:
<pre><code>cake build:examples</code></pre>

<b>Running the examples</b>  
The first example show the basic functionality of a Popapp. Just open `examples/example1/index.html` and take a look.

The second example show an interaction with a simple server that logs when a user dismisses a Popapp. Run the server and browse the example:
<pre><code>cd examples/example2/server-side
node server.js</code></pre>
Browse [`http://localhost:8080`](http://localhost:8080) and enjoy.

Using Popapp with javascript
-----
The examples provided in this page are written in [coffeescript](http://jashkenas.github.com/coffee-script). Of course, you can use it with javascript too. You'll need a couple of `var`'s and semicolons and you are ready to go!

###Dependencies###
[jQuery](http://www.jquery.com)

	



	