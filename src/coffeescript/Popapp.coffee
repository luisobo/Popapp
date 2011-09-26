global_scope = global ? window

'''
Adds center capabilty to jQuery
'''
jQuery.fn.center = ->
	@css('position','absolute')
	@css('top', (($(window).height() - @outerHeight()) / 2) + $(window).scrollTop() + "px")
	@css('left', (($(window).width() - @outerWidth()) / 2) + $(window).scrollLeft() + "px")
	@css('top', (($(window).height() - @outerHeight()) / 2) + $(window).scrollTop() + "px")
	@css('left', (($(window).width() - @outerWidth()) / 2) + $(window).scrollLeft() + "px")
	return this

'''
Checks if an element is attached to the 
'''
jQuery.fn.isAttached =  ->
	result = $('body').find('.' + @attr('class')).length > 0

'''
Adds a property to an object.
Example:
	class MyClass
		constructor: ->
			@property = property #Add support for properties in this class. Do it once
			@property('my_property').set('my initial value')

- Adds a method called 'my_property' to MyClass
- Adds a property called '_my_property' that hold the value itself
- The optional 'set' function sets the value of the property.
'''
property = (name) ->
	# create the private property
	@["_#{name}"] = ''
	
	#adds the getter/mutator
	@[name] = (new_value) ->
		if new_value?
			@["_#{name}"] = new_value
			return this
		else
			@["_#{name}"]
			
	
	#returns the set function
	return a_object =
		set: (initial_value) =>
			@["_#{name}"] = initial_value
	
'''
An easy to use and highly customizable modal popup

Basic usage:
	popapp = new Popapp
	popapp.content '<div>Hello from Popapp!</div>'
	popapp.show()
'''
class global_scope.Popapp
	@MAIN_CLASS: 'popapp_main'
	@POPUP_CLASS: 'popapp_popup'
	@CLOSE_CLASS: 'popapp_close'
	@CONTAINER_CLASS: 'popapp_container'
	
	@IMG_DIR: 'img/'
	
	@DEFAULT =
		POPUP:
			WIDTH : '400px'
			HEIGHT : 'auto'
			COLOR : 'rgb(235, 235, 235)'
		BACKGROUND:
			OPACITY : 0.451
			COLOR : 'black'
		CLOSE:
			MARGIN: '5px'
		CONTAINER:
			MIN_HEIGHT : '220px'
			
	
	constructor: ->
		@main = @_create_main()
		@popup = @_create_popup()
		@close = @_create_close()
		@container = @_create_container()	
		
		@popup.append @close
		@popup.append @container
		
		$(window).resize =>
			@popup.center()

		@visible = false
		
		@close_handlers = []
		@on_close(=> @hide())
	
	''' Shows the popup '''
	show: ->
		if not @visible
			$('body').append @main
			$('body').append @popup
			@popup.center()
			@visible = true
	
	''' Hides the popup '''
	hide: ->
		if @visible
			@main.detach()
			@popup.detach()
			@visible = false
	
	''' Getter/mutator of the popup color '''
	color: (color) ->
		if color?
			@popup_color = color
			@popup.css('background-color', color)
		else
			@popup_color
			
	''' Getter/mutator of the popup content '''
	content: (content, message_id) ->
		if content?
			@_message_id = message_id
			@container.html(content)
			@popup.center()
		else
			@container.html()
			
	''' Returns the id of the message being displayed '''
	message_id: ->
		@_message_id
	
	''' Getter/mutator of the popup width '''
	width: (width) ->
		if width?
			@popup.width(width)
			@popup.center()
		else
			@popup.width()
	
	''' Getter/mutator of the popup height '''		
	height: (height) ->
		if height?
			@popup.height(height)
			@popup.center()
		else
			@popup.height()
	
	'''
	Adds decorators to Popapp.
	See PopupDecorator.
	'''	
	decorate: (decorators...) ->
		for decorator in decorators
			@popup = decorator.decorate_popup(@popup)
			@close = decorator.decorate_close_button(@close)
			@main = decorator.decorate_background(@main)
			@container = decorator.decorate_content(@container)
	
	''' Adds a handler to the close event of the popup. '''
	on_close: (close_handler) ->
		@close_handlers.push close_handler if close_handler?
			
	_create_main: ->
		div = $('<div/>')
		div.addClass(Popapp.MAIN_CLASS)
		div.css('position', 'absolute')
		div.css('top', 0)
		div.css('left', 0)
		div.css('width', '100%')
		div.css('height', '100%')
		div.css('background-color', Popapp.DEFAULT.BACKGROUND.COLOR)
		div.css('opacity', Popapp.DEFAULT.BACKGROUND.OPACITY)
		div
		
	_create_popup: ->
		div = $('<div/>')
		div.addClass(Popapp.POPUP_CLASS)
		div.css('position', 'absolute')
		div.css('background-color', Popapp.DEFAULT.POPUP.COLOR)
		div.css('width', Popapp.DEFAULT.POPUP.WIDTH)
		div.css('height', Popapp.DEFAULT.POPUP.HEIGHT)
		div.css('opacity', 1)
		div.center()
		div
		
	_create_close: ->
		div = $('<div/>')
		div.addClass(Popapp.CLOSE_CLASS)
		div.css('background-image', 'url(' + Popapp.IMG_DIR + 'close_button.png)')
		div.css('float', 'right')
		div.css('margin', Popapp.DEFAULT.CLOSE.MARGIN)
		div.css('width', '25px')
		div.css('height', '25px')
		div.click(=> @_fire_close_handlers())
		div
		
	_create_container: ->
		div = $('<div/>')
		div.addClass(Popapp.CONTAINER_CLASS)
		div.css('white-space', 'wrap')
		div.css('overflow-y', 'auto')
		div.height('100%')
		div.css('min-height', Popapp.DEFAULT.CONTAINER.MIN_HEIGHT)
		div
		
	_fire_close_handlers: ->
		for handler in @close_handlers
			handler(this)
		
class global_scope.PopupDecorator
	decorate_popup: (popup) ->
		popup

	decorate_close_button: (close_button) ->
		close_button

	decorate_background: (background) ->
		background
		
	decorate_content: (content) ->
		content


class RoundCornersAndShadowWithImages extends PopupDecorator

	constructor: ->
		@IMAGE_WIDTH = 40
		@IMAGE_WIDTH_PX = @IMAGE_WIDTH + 'px'
		
	decorate_popup: (popup) ->
		@table = @_create_table()
		popup.replaceWith(@table)
		@table.find('.center')
			.append(popup)
		
		@table
			.css('position', popup.css('position'))
			.css('top', popup.css('top').replace('px', '') - @IMAGE_WIDTH )
			.css('left', popup.css('left').replace('px', '') - @IMAGE_WIDTH)
			.css('width', popup.width() + 2 * @IMAGE_WIDTH)
			.css('height', popup.height() + 2 * @IMAGE_WIDTH)

		popup
			.css('position', 'relative')
			.css('top', '0px')
			.css('left', '0px')
			.css('right', '0px')
			.css('bottom', '0px')
			
	decorate_close_button: (close_button) ->
		close_button.css('margin', '-10px')

		
	_create_table: ->
		table = $('''<table>
									<tbody>
										<tr>
											<td class="topleft"/>
											<td class="top"/>
											<td class="topright"/>
										</tr>
										<tr>
											<td class="left"/>
											<td class="center"/>
											<td class="right"/>
										</tr>
										<tr>
											<td class="bottomleft"/>
											<td class="bottom"/>
											<td class="bottomright"/>
										</tr>''')
		table.attr('cellspacing', 0)
		table.attr('cellpadding', 0)
		table.find('.topleft')
			.css('width', @IMAGE_WIDTH_PX)
			.css('height', @IMAGE_WIDTH_PX)
			.css('background-image', 'url(' + Popapp.IMG_DIR + '/topleft.png)')
		table.find('.top')
			.css('width', 'auto')
			.css('height', @IMAGE_WIDTH_PX)
			.css('background-image', 'url(' + Popapp.IMG_DIR + '/top.png)')
			.css('background-repeat', 'repeat-x')
		table.find('.topright')
			.css('width', @IMAGE_WIDTH_PX)
			.css('height', @IMAGE_WIDTH_PX)
			.css('background-image', 'url(' + Popapp.IMG_DIR + '/topright.png)')
		table.find('.left')
			.css('width', @IMAGE_WIDTH_PX)
			.css('height', 'auto')
			.css('background-image', 'url(' + Popapp.IMG_DIR + '/left.png)')
			.css('background-repeat', 'repeat-y')
		table.find('.right')
			.css('width', 'auto')
			.css('height', @IMAGE_WIDTH_PX)
			.css('background-image', 'url(' + Popapp.IMG_DIR + '/right.png)')
			.css('background-repeat', 'repeat-y')
		table.find('.bottomleft')
			.css('width', @IMAGE_WIDTH_PX)
			.css('height', @IMAGE_WIDTH_PX)
			.css('background-image', 'url(' + Popapp.IMG_DIR + '/bottomleft.png)')
		table.find('.bottom')
			.css('width', 'auto')
			.css('height', @IMAGE_WIDTH_PX)
			.css('background-image', 'url(' + Popapp.IMG_DIR + '/bottom.png)')
			.css('background-repeat', 'repeat-x')
		table.find('.bottomright')
			.css('width', @IMAGE_WIDTH_PX)
			.css('height', @IMAGE_WIDTH_PX)
			.css('background-image', 'url(' + Popapp.IMG_DIR + '/bottomright.png)')
		table
		
	
class global_scope.RoundCornersCss3 extends PopupDecorator
	
	@DEFAULT =
		RADIUS: '25px'
	
	constructor: (radius) ->
		@radius = radius ? RoundCornersCss3.DEFAULT.RADIUS
		@radius = @radius.replace('px','') if typeof @radius is 'string'
		
	decorate_popup: (popup) ->
		@_apply_style_popup(popup, @radius)
		@_correct_popup_position(popup, @radius)
		popup
		
	decorate_close_button: (close_button) ->
		close_button.css('margin', '-10px')
		
	_apply_style_popup: (popup, radius) ->
		popup.css('border-radius', radius + 'px')
		popup.css('-moz-border-radius', radius + 'px')
		popup.css('padding', radius + 'px')
			 	
	_correct_popup_position: (popup, radius) ->
		for position in ['top', 'left', 'bottom', 'rigth']
			old = popup.css(position)
			old = old.replace('px', '') if old?
			popup.css(position, old - radius) if old > 0

class global_scope.ShadowCss3 extends PopupDecorator
	
	@DEFAULT = 
		HORIZONTAL_OFFSET : '0'
		VERTICAL_OFFSET : '10px'
		BLUR : '10px'
		SPREAD : '5px'
		COLOR : '#383838'
		IE_DIRECTION : '90'
		IE_STRENGTH : '2'
	
	constructor: ->
		@property = property
		@property('horizontal_offset').set(ShadowCss3.DEFAULT.HORIZONTAL_OFFSET)
		@property('vertical_offset').set(ShadowCss3.DEFAULT.VERTICAL_OFFSET)
		@property('blur').set(ShadowCss3.DEFAULT.BLUR)
		@property('spread').set(ShadowCss3.DEFAULT.SPREAD)
		@property('color').set(ShadowCss3.DEFAULT.COLOR)
		@property('ie_direction').set(ShadowCss3.DEFAULT.IE_DIRECTION)
		@property('ie_strength').set(ShadowCss3.DEFAULT.IE_STRENGTH)
		
	decorate_popup: (popup) ->
		value = @_create_value()
		@_apply_value(popup, 'box-shadow', value)
		@_apply_value(popup, '-webkit-box-shadow', value)
		@_apply_value(popup, '-moz-box-shadow', value)
		popup.css('filter', @_create_ie_value())

	_apply_value: (element, property, value) ->
		old = element.css(property)
		value = "#{old}, #{value}" if old
		element.css(property, value)
			
	_create_value: ->
		"#{@_horizontal_offset} #{@_vertical_offset} #{@_blur} #{@_spread} #{@_color}"
	_create_ie_value: ->
		"shadow(color=#{@_color}, direction=#{@_ie_direction}, strength=#{@_ie_strength})"
		
	
class global_scope.InnerShadowCss3 extends PopupDecorator
	
	@DEFAULT = 
		HORIZONTAL_OFFSET : '0'
		VERTICAL_OFFSET : '-10px'
		BLUR : '10px'
		SPREAD : '0'
		COLOR : '#A3A3A3'
	
	constructor: ->
		@property = property
		@property('horizontal_offset').set(InnerShadowCss3.DEFAULT.HORIZONTAL_OFFSET)
		@property('vertical_offset').set(InnerShadowCss3.DEFAULT.VERTICAL_OFFSET)
		@property('blur').set(InnerShadowCss3.DEFAULT.BLUR)
		@property('spread').set(InnerShadowCss3.DEFAULT.SPREAD)
		@property('color').set(InnerShadowCss3.DEFAULT.COLOR)
		
	decorate_popup: (popup) ->
		value = @_create_value()
		@_apply_value(popup, 'box-shadow', value)
		@_apply_value(popup, '-webkit-box-shadow', value)
		@_apply_value(popup, '-moz-box-shadow', value)
		
	_apply_value: (element, property, value) ->
		old = element.css(property)
		value = "#{old}, #{value}" if old
		element.css(property, value)
		
	_create_value: ->
		"inset #{@_horizontal_offset} #{@_vertical_offset} #{@_blur} #{@_spread} #{@_color}"
		
		
		