beforeEach ->
	@addMatchers toBeCentered: ->
      	(($(this.actual).css('position') == 'absolute') and	($(this.actual).css('top') == (Math.floor(($(window).height() - this.actual.outerHeight()) / 2) + $(window).scrollTop()) + "px") and	($(this.actual).css('left') == (Math.floor(($(window).width() - this.actual.outerWidth()) / 2) + $(window).scrollLeft()) + "px"))
  