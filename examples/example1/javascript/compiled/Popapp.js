(function() {
  var RoundCornersAndShadowWithImages, global_scope, property;
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; }, __slice = Array.prototype.slice, __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  };
  global_scope = typeof global !== "undefined" && global !== null ? global : window;
  'Adds center capabilty to jQuery';
  jQuery.fn.center = function() {
    this.css('position', 'absolute');
    this.css('top', (($(window).height() - this.outerHeight()) / 2) + $(window).scrollTop() + "px");
    this.css('left', (($(window).width() - this.outerWidth()) / 2) + $(window).scrollLeft() + "px");
    this.css('top', (($(window).height() - this.outerHeight()) / 2) + $(window).scrollTop() + "px");
    this.css('left', (($(window).width() - this.outerWidth()) / 2) + $(window).scrollLeft() + "px");
    return this;
  };
  'Checks if an element is attached to the ';
  jQuery.fn.isAttached = function() {
    var result;
    return result = $('body').find('.' + this.attr('class')).length > 0;
  };
  'Adds a property to an object.\nExample:\n	class MyClass\n		constructor: ->\n			@property = property #Add support for properties in this class. Do it once\n			@property(\'my_property\').set(\'my initial value\')\n\n- Adds a method called \'my_property\' to MyClass\n- Adds a property called \'_my_property\' that hold the value itself\n- The optional \'set\' function sets the value of the property.';
  property = function(name) {
    var a_object;
    this["_" + name] = '';
    this[name] = function(new_value) {
      if (new_value != null) {
        this["_" + name] = new_value;
        return this;
      } else {
        return this["_" + name];
      }
    };
    return a_object = {
      set: __bind(function(initial_value) {
        return this["_" + name] = initial_value;
      }, this)
    };
  };
  'An easy to use and highly customizable modal popup\n\nBasic usage:\n	popapp = new Popapp\n	popapp.content \'<div>Hello from Popapp!</div>\'\n	popapp.show()';
  global_scope.Popapp = (function() {
    Popapp.MAIN_CLASS = 'popapp_main';
    Popapp.POPUP_CLASS = 'popapp_popup';
    Popapp.CLOSE_CLASS = 'popapp_close';
    Popapp.CONTAINER_CLASS = 'popapp_container';
    Popapp.IMG_DIR = 'img/';
    Popapp.DEFAULT = {
      POPUP: {
        WIDTH: '400px',
        HEIGHT: 'auto',
        COLOR: 'rgb(235, 235, 235)'
      },
      BACKGROUND: {
        OPACITY: 0.451,
        COLOR: 'black'
      },
      CLOSE: {
        MARGIN: '5px'
      },
      CONTAINER: {
        MIN_HEIGHT: '220px'
      }
    };
    function Popapp() {
      this.main = this._create_main();
      this.popup = this._create_popup();
      this.close = this._create_close();
      this.container = this._create_container();
      this.popup.append(this.close);
      this.popup.append(this.container);
      $(window).resize(__bind(function() {
        return this.popup.center();
      }, this));
      this.visible = false;
      this.close_handlers = [];
      this.on_close(__bind(function() {
        return this.hide();
      }, this));
    }
    ' Shows the popup ';
    Popapp.prototype.show = function() {
      if (!this.visible) {
        $('body').append(this.main);
        $('body').append(this.popup);
        this.popup.center();
        return this.visible = true;
      }
    };
    ' Hides the popup ';
    Popapp.prototype.hide = function() {
      if (this.visible) {
        this.main.detach();
        this.popup.detach();
        return this.visible = false;
      }
    };
    ' Getter/mutator of the popup color ';
    Popapp.prototype.color = function(color) {
      if (color != null) {
        this.popup_color = color;
        return this.popup.css('background-color', color);
      } else {
        return this.popup_color;
      }
    };
    ' Getter/mutator of the popup content ';
    Popapp.prototype.content = function(content, message_id) {
      if (content != null) {
        this._message_id = message_id;
        this.container.html(content);
        return this.popup.center();
      } else {
        return this.container.html();
      }
    };
    ' Returns the id of the message being displayed ';
    Popapp.prototype.message_id = function() {
      return this._message_id;
    };
    ' Getter/mutator of the popup width ';
    Popapp.prototype.width = function(width) {
      if (width != null) {
        this.popup.width(width);
        return this.popup.center();
      } else {
        return this.popup.width();
      }
    };
    ' Getter/mutator of the popup height ';
    Popapp.prototype.height = function(height) {
      if (height != null) {
        this.popup.height(height);
        return this.popup.center();
      } else {
        return this.popup.height();
      }
    };
    'Adds decorators to Popapp.\nSee PopupDecorator.';
    Popapp.prototype.decorate = function() {
      var decorator, decorators, _i, _len, _results;
      decorators = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      _results = [];
      for (_i = 0, _len = decorators.length; _i < _len; _i++) {
        decorator = decorators[_i];
        this.popup = decorator.decorate_popup(this.popup);
        this.close = decorator.decorate_close_button(this.close);
        this.main = decorator.decorate_background(this.main);
        _results.push(this.container = decorator.decorate_content(this.container));
      }
      return _results;
    };
    ' Adds a handler to the close event of the popup. ';
    Popapp.prototype.on_close = function(close_handler) {
      if (close_handler != null) {
        return this.close_handlers.push(close_handler);
      }
    };
    Popapp.prototype._create_main = function() {
      var div;
      div = $('<div/>');
      div.addClass(Popapp.MAIN_CLASS);
      div.css('position', 'absolute');
      div.css('top', 0);
      div.css('left', 0);
      div.css('width', '100%');
      div.css('height', '100%');
      div.css('background-color', Popapp.DEFAULT.BACKGROUND.COLOR);
      div.css('opacity', Popapp.DEFAULT.BACKGROUND.OPACITY);
      return div;
    };
    Popapp.prototype._create_popup = function() {
      var div;
      div = $('<div/>');
      div.addClass(Popapp.POPUP_CLASS);
      div.css('position', 'absolute');
      div.css('background-color', Popapp.DEFAULT.POPUP.COLOR);
      div.css('width', Popapp.DEFAULT.POPUP.WIDTH);
      div.css('height', Popapp.DEFAULT.POPUP.HEIGHT);
      div.css('opacity', 1);
      div.center();
      return div;
    };
    Popapp.prototype._create_close = function() {
      var div;
      div = $('<div/>');
      div.addClass(Popapp.CLOSE_CLASS);
      div.css('background-image', 'url(' + Popapp.IMG_DIR + 'close_button.png)');
      div.css('float', 'right');
      div.css('margin', Popapp.DEFAULT.CLOSE.MARGIN);
      div.css('width', '25px');
      div.css('height', '25px');
      div.click(__bind(function() {
        return this._fire_close_handlers();
      }, this));
      return div;
    };
    Popapp.prototype._create_container = function() {
      var div;
      div = $('<div/>');
      div.addClass(Popapp.CONTAINER_CLASS);
      div.css('white-space', 'wrap');
      div.css('overflow-y', 'auto');
      div.height('100%');
      div.css('min-height', Popapp.DEFAULT.CONTAINER.MIN_HEIGHT);
      return div;
    };
    Popapp.prototype._fire_close_handlers = function() {
      var handler, _i, _len, _ref, _results;
      _ref = this.close_handlers;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        handler = _ref[_i];
        _results.push(handler(this));
      }
      return _results;
    };
    return Popapp;
  })();
  global_scope.PopupDecorator = (function() {
    function PopupDecorator() {}
    PopupDecorator.prototype.decorate_popup = function(popup) {
      return popup;
    };
    PopupDecorator.prototype.decorate_close_button = function(close_button) {
      return close_button;
    };
    PopupDecorator.prototype.decorate_background = function(background) {
      return background;
    };
    PopupDecorator.prototype.decorate_content = function(content) {
      return content;
    };
    return PopupDecorator;
  })();
  RoundCornersAndShadowWithImages = (function() {
    __extends(RoundCornersAndShadowWithImages, PopupDecorator);
    function RoundCornersAndShadowWithImages() {
      this.IMAGE_WIDTH = 40;
      this.IMAGE_WIDTH_PX = this.IMAGE_WIDTH + 'px';
    }
    RoundCornersAndShadowWithImages.prototype.decorate_popup = function(popup) {
      this.table = this._create_table();
      popup.replaceWith(this.table);
      this.table.find('.center').append(popup);
      this.table.css('position', popup.css('position')).css('top', popup.css('top').replace('px', '') - this.IMAGE_WIDTH).css('left', popup.css('left').replace('px', '') - this.IMAGE_WIDTH).css('width', popup.width() + 2 * this.IMAGE_WIDTH).css('height', popup.height() + 2 * this.IMAGE_WIDTH);
      return popup.css('position', 'relative').css('top', '0px').css('left', '0px').css('right', '0px').css('bottom', '0px');
    };
    RoundCornersAndShadowWithImages.prototype.decorate_close_button = function(close_button) {
      return close_button.css('margin', '-10px');
    };
    RoundCornersAndShadowWithImages.prototype._create_table = function() {
      var table;
      table = $('<table>\n<tbody>\n	<tr>\n		<td class="topleft"/>\n		<td class="top"/>\n		<td class="topright"/>\n	</tr>\n	<tr>\n		<td class="left"/>\n		<td class="center"/>\n		<td class="right"/>\n	</tr>\n	<tr>\n		<td class="bottomleft"/>\n		<td class="bottom"/>\n		<td class="bottomright"/>\n	</tr>');
      table.attr('cellspacing', 0);
      table.attr('cellpadding', 0);
      table.find('.topleft').css('width', this.IMAGE_WIDTH_PX).css('height', this.IMAGE_WIDTH_PX).css('background-image', 'url(' + Popapp.IMG_DIR + '/topleft.png)');
      table.find('.top').css('width', 'auto').css('height', this.IMAGE_WIDTH_PX).css('background-image', 'url(' + Popapp.IMG_DIR + '/top.png)').css('background-repeat', 'repeat-x');
      table.find('.topright').css('width', this.IMAGE_WIDTH_PX).css('height', this.IMAGE_WIDTH_PX).css('background-image', 'url(' + Popapp.IMG_DIR + '/topright.png)');
      table.find('.left').css('width', this.IMAGE_WIDTH_PX).css('height', 'auto').css('background-image', 'url(' + Popapp.IMG_DIR + '/left.png)').css('background-repeat', 'repeat-y');
      table.find('.right').css('width', 'auto').css('height', this.IMAGE_WIDTH_PX).css('background-image', 'url(' + Popapp.IMG_DIR + '/right.png)').css('background-repeat', 'repeat-y');
      table.find('.bottomleft').css('width', this.IMAGE_WIDTH_PX).css('height', this.IMAGE_WIDTH_PX).css('background-image', 'url(' + Popapp.IMG_DIR + '/bottomleft.png)');
      table.find('.bottom').css('width', 'auto').css('height', this.IMAGE_WIDTH_PX).css('background-image', 'url(' + Popapp.IMG_DIR + '/bottom.png)').css('background-repeat', 'repeat-x');
      table.find('.bottomright').css('width', this.IMAGE_WIDTH_PX).css('height', this.IMAGE_WIDTH_PX).css('background-image', 'url(' + Popapp.IMG_DIR + '/bottomright.png)');
      return table;
    };
    return RoundCornersAndShadowWithImages;
  })();
  global_scope.RoundCornersCss3 = (function() {
    __extends(RoundCornersCss3, PopupDecorator);
    RoundCornersCss3.DEFAULT = {
      RADIUS: '25px'
    };
    function RoundCornersCss3(radius) {
      this.radius = radius != null ? radius : RoundCornersCss3.DEFAULT.RADIUS;
      if (typeof this.radius === 'string') {
        this.radius = this.radius.replace('px', '');
      }
    }
    RoundCornersCss3.prototype.decorate_popup = function(popup) {
      this._apply_style_popup(popup, this.radius);
      this._correct_popup_position(popup, this.radius);
      return popup;
    };
    RoundCornersCss3.prototype.decorate_close_button = function(close_button) {
      return close_button.css('margin', '-10px');
    };
    RoundCornersCss3.prototype._apply_style_popup = function(popup, radius) {
      popup.css('border-radius', radius + 'px');
      popup.css('-moz-border-radius', radius + 'px');
      return popup.css('padding', radius + 'px');
    };
    RoundCornersCss3.prototype._correct_popup_position = function(popup, radius) {
      var old, position, _i, _len, _ref, _results;
      _ref = ['top', 'left', 'bottom', 'rigth'];
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        position = _ref[_i];
        old = popup.css(position);
        if (old != null) {
          old = old.replace('px', '');
        }
        _results.push(old > 0 ? popup.css(position, old - radius) : void 0);
      }
      return _results;
    };
    return RoundCornersCss3;
  })();
  global_scope.ShadowCss3 = (function() {
    __extends(ShadowCss3, PopupDecorator);
    ShadowCss3.DEFAULT = {
      HORIZONTAL_OFFSET: '0',
      VERTICAL_OFFSET: '10px',
      BLUR: '10px',
      SPREAD: '5px',
      COLOR: '#383838',
      IE_DIRECTION: '90',
      IE_STRENGTH: '2'
    };
    function ShadowCss3() {
      this.property = property;
      this.property('horizontal_offset').set(ShadowCss3.DEFAULT.HORIZONTAL_OFFSET);
      this.property('vertical_offset').set(ShadowCss3.DEFAULT.VERTICAL_OFFSET);
      this.property('blur').set(ShadowCss3.DEFAULT.BLUR);
      this.property('spread').set(ShadowCss3.DEFAULT.SPREAD);
      this.property('color').set(ShadowCss3.DEFAULT.COLOR);
      this.property('ie_direction').set(ShadowCss3.DEFAULT.IE_DIRECTION);
      this.property('ie_strength').set(ShadowCss3.DEFAULT.IE_STRENGTH);
    }
    ShadowCss3.prototype.decorate_popup = function(popup) {
      var value;
      value = this._create_value();
      this._apply_value(popup, 'box-shadow', value);
      this._apply_value(popup, '-webkit-box-shadow', value);
      this._apply_value(popup, '-moz-box-shadow', value);
      return popup.css('filter', this._create_ie_value());
    };
    ShadowCss3.prototype._apply_value = function(element, property, value) {
      var old;
      old = element.css(property);
      if (old) {
        value = "" + old + ", " + value;
      }
      return element.css(property, value);
    };
    ShadowCss3.prototype._create_value = function() {
      return "" + this._horizontal_offset + " " + this._vertical_offset + " " + this._blur + " " + this._spread + " " + this._color;
    };
    ShadowCss3.prototype._create_ie_value = function() {
      return "shadow(color=" + this._color + ", direction=" + this._ie_direction + ", strength=" + this._ie_strength + ")";
    };
    return ShadowCss3;
  })();
  global_scope.InnerShadowCss3 = (function() {
    __extends(InnerShadowCss3, PopupDecorator);
    InnerShadowCss3.DEFAULT = {
      HORIZONTAL_OFFSET: '0',
      VERTICAL_OFFSET: '-10px',
      BLUR: '10px',
      SPREAD: '0',
      COLOR: '#A3A3A3'
    };
    function InnerShadowCss3() {
      this.property = property;
      this.property('horizontal_offset').set(InnerShadowCss3.DEFAULT.HORIZONTAL_OFFSET);
      this.property('vertical_offset').set(InnerShadowCss3.DEFAULT.VERTICAL_OFFSET);
      this.property('blur').set(InnerShadowCss3.DEFAULT.BLUR);
      this.property('spread').set(InnerShadowCss3.DEFAULT.SPREAD);
      this.property('color').set(InnerShadowCss3.DEFAULT.COLOR);
    }
    InnerShadowCss3.prototype.decorate_popup = function(popup) {
      var value;
      value = this._create_value();
      this._apply_value(popup, 'box-shadow', value);
      this._apply_value(popup, '-webkit-box-shadow', value);
      return this._apply_value(popup, '-moz-box-shadow', value);
    };
    InnerShadowCss3.prototype._apply_value = function(element, property, value) {
      var old;
      old = element.css(property);
      if (old) {
        value = "" + old + ", " + value;
      }
      return element.css(property, value);
    };
    InnerShadowCss3.prototype._create_value = function() {
      return "inset " + this._horizontal_offset + " " + this._vertical_offset + " " + this._blur + " " + this._spread + " " + this._color;
    };
    return InnerShadowCss3;
  })();
}).call(this);
