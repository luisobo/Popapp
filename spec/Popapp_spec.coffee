global_scope = global ? window

describe 'Popapp', ->
	
	#utily methods
	global_scope.main_div = -> $('.' + Popapp.MAIN_CLASS)
	global_scope.popup_div = -> $('.' + Popapp.POPUP_CLASS)
	global_scope.close_div = -> $('.' + Popapp.CLOSE_CLASS)
	global_scope.content_div = -> $('.' + Popapp.CONTAINER_CLASS)

	popapp = ''

	beforeEach ->
		popapp = new Popapp
	
	afterEach ->
		main_div().detach()
		popup_div().detach()
		
	describe 'before it has been shown', ->
		describe '#color', ->
			it 'changes the popup color', ->
				some_color = 'rgb(11, 22, 33)'
				popapp.color(some_color)
				
				expect(popapp.color()).toEqual(some_color)
				
		describe '#content', ->
			it 'changes the content of the popup', ->
				content = '<div>Hello! I\'m Popapp!</div>'
				
				popapp.content(content)
				
				expect(popapp.content()).toEqual(content)
		
				
		describe '#width', ->
			it 'changes the width of the popup', ->
				some_width = 400
				popapp.width(some_width)
				
				expect(popapp.width()).toEqual(some_width)
				
		describe '#height', ->
			it 'changes the height of the popup', ->
				some_height = 500
				popapp.height(some_height)
				
				expect(popapp.height()).toEqual(some_height)
		
	describe 'when it is shown', ->
		it 'inserts the popapp main div in the body', ->
			popapp.show()
			
			div = main_div()
			expect(div).toNotBe(null)
			expect(div).toHaveClass(Popapp.MAIN_CLASS)
			
		it 'inserts the popapp div in the bg div', ->
			popapp.show()

			div = popup_div()
			expect(div).toNotBe(null)
			expect(div).toHaveClass(Popapp.POPUP_CLASS)
			
		it 'cannot be shown again', ->
			spyOn($.fn, 'append').andCallThrough()
			popapp.show()
			popapp.show()

			expect($.fn.append.callCount).toEqual 2

			
		it 'has a close button', ->
			popapp.show()
			expect(popup_div()).toContain('.' + Popapp.CLOSE_CLASS)
		
		describe 'the main div', ->
			it 'has absolute positioning', ->
				popapp.show()
				
				div = main_div()
				expect(div.css('position')).toEqual('absolute')
			
			it 'fills the window', ->
				popapp.show()
				div = main_div()

				expect(div.css('top')).toEqual('0px')
				expect(div.css('left')).toEqual('0px')
				expect(div.css('width')).toEqual $(window).width() + 'px'
				expect(div.css('height')).toEqual $(window).height() + 'px'

			
			it 'has a grey translucent background', ->
				popapp.show()
			
				div = main_div()
				expect(div.css('background-color')).toEqual 'rgb(0, 0, 0)'
			
			it 'has a 0.40 alpha', ->
				popapp.show()
			
				div = main_div()
				expect(div.css('opacity')).toBeCloseTo(0.45)

		describe 'the popup div', ->		
			it 'has a rgb(235, 235, 235) background color by default', ->
				popapp.show()
				
				div = popup_div()
				expect(div.css('background-color')).toEqual('rgb(235, 235, 235)')
			
			it 'is 400px wide by default', ->
				popapp.show()
				
				div = popup_div()
				expect(div.css('width')).toEqual '400px'	
			
			it 'is at least 220px tall by default', ->
				popapp.show()

				div =	popup_div()	
				expect(div.css('height')).toEqual '220px'
				
			it 'is centered', ->
				popapp.show()
				
				expect(popup_div()).toBeCentered()

			
		describe 'the close button', ->
			it 'is floating right', ->
				popapp.show()
				
				expect(close_div().css('float')).toEqual 'right'
				
			it 'has a 5px margin by default', ->
				popapp.show()
				
				expect(close_div().css('margin-top')).toEqual '5px'
				expect(close_div().css('margin-right')).toEqual '5px'
				expect(close_div().css('margin-bottom')).toEqual '5px'
				expect(close_div().css('margin-left')).toEqual '5px'
			
		describe '#color', ->
			it 'changes the popup background color', ->
				grey = 'rgb(242, 242, 242)'
				popapp.color grey
				popapp.show()

				div = popup_div()
				expect(div.css('background-color')).toEqual grey

		describe '#content', ->
			it 'changes the content inner HTML', ->
				content = '<p>Hello PopApp!</p>'
				popapp.content content
				popapp.show()

				expect(content_div()).toHaveHtml(content)
				
		describe '#width', ->
			it 'changes the popup div width', ->
				some_width = 800
				popapp.show()
				popapp.width(some_width)
				
				expect(popup_div().width()).toEqual some_width
				
			it 'keeps the popup div centered', ->
				some_width = 800
				popapp.show()
				popapp.width(some_width)
				
				expect(popup_div()).toBeCentered()
				
		describe '#height', ->
			it 'changes the popup div height', ->
				some_height = 500
				popapp.show()
				popapp.height(some_height)
				
				expect(popup_div().height()).toEqual some_height
				
			it 'keeps the popup div centered', ->
				some_height = 500
				popapp.show()
				popapp.height(some_height)
				
				expect(popup_div()).toBeCentered()
				

				