/**
 * This is functions used both in client and admin interface
 * */

'use strict';

var confirmMsg = '';
var IPV4REGEXP = "^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$|^(([a-zA-Z]|[a-zA-Z][a-zA-Z0-9\-]*[a-zA-Z0-9])\.)*([A-Za-z]|[A-Za-z][A-Za-z0-9\-]*[A-Za-z0-9])$|^\s*((([0-9A-Fa-f]{1,4}:){7}([0-9A-Fa-f]{1,4}|:))|(([0-9A-Fa-f]{1,4}:){6}(:[0-9A-Fa-f]{1,4}|((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){5}(((:[0-9A-Fa-f]{1,4}){1,2})|:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){4}(((:[0-9A-Fa-f]{1,4}){1,3})|((:[0-9A-Fa-f]{1,4})?:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){3}(((:[0-9A-Fa-f]{1,4}){1,4})|((:[0-9A-Fa-f]{1,4}){0,2}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){2}(((:[0-9A-Fa-f]{1,4}){1,5})|((:[0-9A-Fa-f]{1,4}){0,3}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){1}(((:[0-9A-Fa-f]{1,4}){1,6})|((:[0-9A-Fa-f]{1,4}){0,4}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(:(((:[0-9A-Fa-f]{1,4}){1,7})|((:[0-9A-Fa-f]{1,4}){0,5}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:)))(%.+)?\s*$";

function capitalizeFirst(string) {
  return string && string.charAt(0).toUpperCase() + string.slice(1);
}

function checkval(url) {
  
  var val;
  var field = document.getElementById('pagevalue').value;
  if (field == '')
    return alert('#pagevalue value is empty');
  
  val = parseInt(field);
  
  if (isNaN(val))
    return alert('#pagevalue.value is not a number!');
  
  if (val != field)
    return alert('Error parsing #pagevalue.value');
  
  if (val <= 0)
    return alert('Value is less than zero');
  
  window.location = url + val;
}

function showHidePageJump() {
  if (document.getElementById('pageJumpWindow').style.display == 'block') {
    document.getElementById('pageJumpWindow').style.display = 'none';
  } else {
    document.getElementById('pageJumpWindow').style.display = 'block';
  }
}

function cancelEvent(e) {
  var event = e || window.event;
  if (event.preventDefault) {event.preventDefault()}
  if (event.stopPropagation) {event.stopPropagation()}
  event.cancelBubble = true;
  return false;
}

function clickButton(id) {
  var btn = document.getElementById(id);
  if (btn)
    btn.click();
}

function randomString(length) {
  var text     = "";
  var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
  for (var i = 0; i < length; i++) {
    text += possible.charAt(Math.floor(Math.random() * possible.length));
  }
  return text;
}

function displayJSONTooltip(result) {
  try {
    
    // Find message
    var message = null;
    var response_keys = Object.keys(result);
    
    for (var i = 0; i <= response_keys.length; i++){
      var key_name = response_keys[i];
      if (key_name && key_name.match('^MESSAGE_?')){
        message = result[key_name];
        break;
      }
    }
    
    if (message !== 'null') {
      var text = '<h3>' + (message['caption'] || '') + '</h3>';
      if (message['messaga']) {
        text += ' : <h4>' + (message['messaga'] || '') + '</h4>';
      }
      
      var alert_classes = {
        info   : 'success',
        err    : 'danger',
        warning: 'warn'
      };
      
      aTooltip
          .setText(text)
          .setClass(alert_classes[message['message_type']] || 'info')
          .show();
    }
    else {
      aTooltip.displayError('Empty data');
      return false;
    }
  }
  catch (RequestError) {
    aTooltip.displayError(RequestError);
    return false;
  }
  return true;
}

/**
 * Displays an confirmation box beforme to submit a "DROP/DELETE/ALTER" query.
 * This function is called while clicking links
 *
 * @return  boolean  whether to run the query or not
 * @param theLink
 * @param Message
 * @param CustomMsg
 */
function confirmLink(theLink, Message, CustomMsg) {
  if (CustomMsg != undefined) {
    confirmMsg = CustomMsg;
  }
  
  var is_confirmed = confirm(confirmMsg + Message);
  if (is_confirmed) {
    theLink.href += '&is_js_confirmed=1';
  }
  
  return is_confirmed;
}

/**
 * Copy one input form to other
 *
 * @param   from, to   the form name
 *
 * @return  boolean  always true
 */
function CopyInputField(from, to) {
  document.getElementById(to).value = document.getElementById(from).value;
  return true;
}

/*
 * Disable button after click
 * @param obj, object text
 *
 * @return  boolean  always true
 */
function renameAndDisable(id, text) {
  
  var $obj = $('#' + id);
  
  $obj.addClass('disabled');
  
  if ($obj.text && typeof($obj.text) === 'function') {
    $obj.text(text);
  }
  
  if ($obj.val && typeof($obj.val) === 'function') {
    $obj.val(text);
  }
  
  $obj.on('click', cancelEvent);
  
  return true;
}

function isDefined(object) {
  return typeof (object) !== 'undefined';
}


function getGlyphicon(iconName) {
  return "<span class='glyphicon glyphicon-" + iconName + "'></span>";
}

function showCommentsModal(title, link_to_confirm, attr) {
  attr = attr || {};
  
  //Cache DOM
  var $modal   = $('#comments_add');
  var $mHeader = $modal.find('#mHeader');
  var $mTitle  = $modal.find('#mTitle');
  var $mForm   = $modal.find('#mForm');
  
  // Set up modal
  $mTitle.html(title);
  
  var type         = attr.type || 'comment';
  var ajax_submit  = attr.ajax;
  var event_submit = attr.event;
  
  var submit_types = {
    'default': function (link) {
      window.location.replace(link);
    },
    'ajax'   : function (link) {
      // Save original state of modal
      var clear_comments_modal = $modal.html();
      
      link += '&json=1&header=2&MESSAGE_ONLY=1';
      
      $.getJSON(link, function (data) {
        displayJSONTooltip(data);
        Events.emit('AJAX_SUBMIT.' + ajax_submit, data);
      });
      
      // Revert HTML changes for modal, so next time it's clear
      $modal.on('hidden.bs.modal', function () {
        $modal.html(clear_comments_modal);
      });
    },
    'event'  : function(){
      Events.emit(attr.event || '');
    }
  };
  
  var submitForm = ajax_submit
      ? submit_types['ajax']
      : event_submit
          ? submit_types['event']
          : submit_types['default'];
  
  $mForm.off('submit');
  
  if (type === 'confirm') {
    $modal.find('.modal-body').remove();
    $mForm.on('submit', function (e) {
      e.preventDefault();
      submitForm(link_to_confirm);
      $modal.modal('hide');
    })
  }
  else {
    var $mInput = $mForm.find('#mInput');
    //Focus input when showing modal
    $modal.on('shown.bs.modal', function () {
      $mInput.focus();
    });
    
    $mForm.on('submit', function (e) {
      e.preventDefault();
      var comments = $mInput.val();
      
      // Check if comments are present and ask if no
      if (comments === '' || comments === null) {
        
        $mHeader.removeClass('alert-info');
        $mHeader.addClass('alert-danger');
        
        $mTitle.html(_COMMENTS_PLEASE + '!');
        return false;
      }
      
      // Append comments, and send
      var url = link_to_confirm + '&COMMENTS=' + comments;
      submitForm(url);
      
      // Finish
      $modal.modal('hide');
    });
  }
  
  $modal.modal('show');
}

function defineCommentModalLogic(context) {
  var $modal_open_buttons = $('a[data-target="#comments_add"]', context);
  
  $modal_open_buttons.click(function () {
    var $this = $(this);
    
    showCommentsModal($this.data('title'), $this.data('confirmed_link'), {
      ajax: $this.data('ajax-submit'),
      type: $this.data('type')
    });
  });
}
/**
 * Main function to get user location. By default tries to set values to #location_x and #location_y inputs.
 * successCallback is called with [x,y] as an argument.
 *
 * @param successCallback function with 1 argument [x, y]
 * @param errorCallback
 * @param notInForm - if true, not trying to find #location_x and #location_y inputs !NOT CALLING SUCCESS CALLBACK
 *
 * Anykey
 */
function getLocation(successCallback, errorCallback, notInForm) {
  
  function success(position) {
    var x = position.coords.latitude;
    var y = position.coords.longitude;
    
    if (!notInForm) {
      $('#location_x').val(position.coords.latitude);
      $('#location_y').val(position.coords.longitude);
    } else {
      return [x, y];
    }
    
    if (successCallback) {
      successCallback([x, y]);
    }
  }
  
  function error() {
    if (errorCallback) {
      errorCallback();
    }
  }
  
  var options = {
    enableHighAccuracy: true,
    timeout           : 120000,
    maximumAge        : 0
  };
  
  navigator.geolocation.getCurrentPosition(success, error, options);
}

var aColorPalette = new AColorPalette();

function AColorPalette(colorsArray) {
  this.counter = 0;
  this.array   = colorsArray || [
        '#F44336', // Red
        '#2196F3', // Blue
        '#4CAF50', // Green
        '#FFEB3B', // Yellow
        
        '#00BCD4', // Cyan
        '#CDDC39', // Lime
        '#9C27B0', // Purple
        '#009688', // Teal
        
        '#8BC34A', // Light Green
        '#607D8B', // Blue Grey
        '#9E9E9E', // Grey
        '#FF9800', // Orange
        
        '#795548', // Brown
        '#3F51B5', // Indigo
        '#FFC107', // Amber
        '#673AB7', // Deep Purple
        
        '#FF5722', // Deep Orange
        '#E91E63', // Pink
        '#03A9F4' // Light Blue
      ];
  
}

AColorPalette.prototype.getNextColorHex = function () {
  //this.checkCounter();
  return this.array[this.counter++ % this.array.length];
};

AColorPalette.prototype.getCurrentColorHex = function () {
  return this.array[(this.counter - 1) % this.array.length];
};

AColorPalette.prototype.getNextColorRGB = function () {
  return this.convertHexToRGB(this.getNextColorHex());
};

AColorPalette.prototype.getNextColorRGBA = function (opacity) {
  return this.convertHexToRGBA(this.getNextColorHex(), opacity);
};

AColorPalette.prototype.convertHexToRGB = function (hex) {
  var numbersHex = hex.substring(1); //removing '#'
  
  var rHex = numbersHex.substring(0, 2);
  var gHex = numbersHex.substring(2, 4);
  var bHex = numbersHex.substring(4, 6);
  
  var r = parseInt(rHex, 16) || 0;
  var g = parseInt(gHex, 16) || 0;
  var b = parseInt(bHex, 16) || 0;
  
  return 'rgb(' + r + ', ' + g + ', ' + b + ')';
};

AColorPalette.prototype.convertHexToRGBA = function (hex, opacity) {
  var numbersHex = hex.substring(1); //removing '#'
  
  var rHex = numbersHex.substring(0, 2) || 0;
  var gHex = numbersHex.substring(2, 4) || 0;
  var bHex = numbersHex.substring(4, 6) || 0;
  
  var r = parseInt(rHex, 16);
  var g = parseInt(gHex, 16);
  var b = parseInt(bHex, 16);
  
  return 'rgba(' + r + ', ' + g + ', ' + b + ', ' + opacity + ')';
};

AColorPalette.prototype.getColorsCount = function () {
  return this.array.length;
};

AColorPalette.prototype.getColorHex = function (index) {
  return this.array[index];
};

AColorPalette.prototype.getColorRGB = function (index) {
  return this.convertHexToRGB(this.array[index]);
};

AColorPalette.prototype.getColorRGBA = function (index, opacity) {
  return this.convertHexToRGBA(this.array[index], opacity);
};

AColorPalette.prototype.clear = function () {
  this.counter = -1;
};

function defineResetInputLogic(context) {
  $('input[type=reset]', context).on('click', updateChosen);
}

/**
 * Activates on click toggle for blocks
 *
 * @param first_block_id - DOM element id
 * @param second_block_id - DOM element id
 * @constructor
 */
function BlockToggler(first_block_id, second_block_id) {
  this.first_visible = true;
  
  this.first_block  = jQuery('#' + first_block_id);
  this.second_block = jQuery('#' + second_block_id);
  
  this.first_block.find('a[data-toggle="block"]').on('click', this.toggle.bind(this));
  this.second_block.find('a[data-toggle="block"]').on('click', this.toggle.bind(this));
}
BlockToggler.prototype.toggle     = function () {
  this.first_visible
      ? this.showSecond()
      : this.showFirst();
};
BlockToggler.prototype.showFirst  = function () {
  this.first_block.show();
  this.second_block.hide();
  
  this.first_visible = true;
};
BlockToggler.prototype.showSecond = function () {
  this.second_block.show();
  this.first_block.hide();
  
  this.first_visible = false;
};

/**
 * Returns string that is desired length long.
 * placeholder is appended to a start of string
 *
 * @param string
 * @param desiredLength
 * @param placeholder symbol to prepend to string. Default is "0"
 * @returns {string}
 */
function ensureLength(string, desiredLength, placeholder) {
  //assert string is a string;
  string += "";
  
  placeholder = placeholder || "0";
  
  while (string.length < desiredLength) {
    string = placeholder.concat(string);
  }
  
  return string;
}

function fixCheckboxSendValue(context) {
  $('form', context).on('submit', function () {
    var $checkboxes = $(this).find('input[type="checkbox"]').filter('[data-return="1"]');
    
    if ($checkboxes.length > 0) {
      $.each($checkboxes, function (i, checkbox) {
        var $checkbox = $(checkbox);
        if (!$checkbox.prop('checked')) {
          
          var newCheckbox = $('<input/>', {
            type   : 'hidden',
            name   : $checkbox.attr('name'),
            value  : 0,
            'class': 'generated-checkbox'
          });
          
          $checkbox.parent().append(newCheckbox);
        }
      });
    }
    
  });
}

function renewChosenValue($select, value) {
  var $options = $select.find('option[value="' + value + '"]');
  
  if ($options.length) {
    $select.val(value);
  }
  
  updateChosen();
}

function updateChosen(callback, instant) {
  
  var update = function () {
    $('select').trigger('chosen:updated');
    if (callback) callback();
  };
  
  if (instant) {
    return update();
  }
  
  setTimeout(update, 100);
}

function defineCheckPatternLogic(context) {
  'use strict';
  var $patternedInputs = $('input[data-check-for-pattern]', context);
  
  $patternedInputs.on('input', function () {
    var $this = $(this);
    var value = this.value;
    
    var pattern = new RegExp($this.attr('data-check-for-pattern'));
    
    if (!pattern.test(value)) {
      $this.parents('.form-group').addClass('has-error');
    }
    else {
      $this.parents('.form-group').removeClass('has-error');
    }
    
  });
}

function defineLinkedInputsLogic(context) {
  
  function disableSingleLinked(i, e) {
    var $e = $(e);
    $e.prop('disabled', true);
    $e.addClass('disabled');
    
    if ($e.is('select')) {
      disableSingleLinked(i, $e.next('div.chosen-container'));
      updateChosen();
    }
    
    if ($e.data('is-checkbox')) {
      $e.data('was-checked', $e.prop('checked'));
      $e.prop('checked', false);
    }
  }
  
  function enableSingleLinked(i, e) {
    var $e = $(e);
    $e.prop('disabled', false);
    $e.removeClass('disabled');
    
    if ($e.is('select')) {
      enableSingleLinked(i, $e.next('div.chosen-container'));
      updateChosen();
    }
    
    if ($e.data('is-checkbox')) {
      $e.prop('checked', $e.data('was-checked'));
    }
  }
  
  function disableAllLinked(e, enable) {
    var $this     = $(e);
    var value     = $this.val();
    var linked_id = $this.data('input' + ((enable) ? '-enables' : '-disables'));
    var $linked   = [];
    
    // Saving reference to all linked inputs
    linked_id.split(',').map(function (id) {
      $linked.push($('#' + id));
    });
    
    var has_value = $this.data('is-checkbox')
        ? ($this.prop('checked'))
        : ( value !== '' );
    
    if (enable !== true) {
      $.each($linked, has_value
                        ? disableSingleLinked
                        : enableSingleLinked
      )
    }
    else {
      $.each($linked, has_value
                        ? enableSingleLinked
                        : disableSingleLinked
      )
    }
  }
  
  var $linkedForDisableInputs = $('[data-input-disables]', context);
  var $linkedForEnableInputs  = $('[data-input-enables]', context);
  
  if ($linkedForDisableInputs.length > 0) {
    $.each($linkedForDisableInputs, function (i, e) {
      var $this = $(e);
      $this.data('is-checkbox', $this.is('input[type="checkbox"]'));
      $this.data('is-select', $this.is('select'));
      
      var event_name = ($this.data('is-checkbox') || $this.data('is-select')) ? 'change' : 'input';
      
      $this.on(event_name, function () {
        disableAllLinked(this);
      });
      
      disableAllLinked(e)
    });
  }
  if ($linkedForEnableInputs.length > 0) {
    $.each($linkedForEnableInputs, function (i, e) {
      var $this = $(e);
      $this.data('is-checkbox', $this.is('input[type="checkbox"]'));
      
      var event_name = $this.data('is-checkbox') ? 'change' : 'input';
      
      $this.on(event_name, function () {
        disableAllLinked(this, true);
      });
      
      disableAllLinked(e, true)
    });
  }
}

function defineIpInputLogic(context) {
  $('.ip-input', context).attr('data-check-for-pattern', IPV4REGEXP);
  
  $('.mac-input', context).on('click', function () {
    if (this.value.indexOf(':') == -1) {
      this.value = this.value.replace(/-/g, ':');
    }
    else {
      this.value = this.value.replace(/:/g, '-');
    }
  });
  
}

function isValidIp(ip) {
  //RegExp test for valid ipv4 and ipv6
  var ipRegularExpression = new RegExp(IPV4REGEXP);
  return ipRegularExpression.test(ip);
}


function isValidIpv4(ip) {
  if (ip.indexOf('.') != -1) {
    var octets = ip.split('.');
    
    if (octets.length != 4) return false;
    
    var result = true;
    $.each(octets, function (index, octet) {
      if (octet < 0 && octet > 255) result = false;
    });
    return result;
    
  } else {
    return false;
  }
}

/** Log levels */
var LEVEL_INFO    = 1;
var LEVEL_WARNING = 2;
var LEVEL_ERROR   = 3;
var LEVEL_DEBUG   = 4;

/** Global log_level treshold */
var LOG_LEVEL = LEVEL_INFO;

function _log(level, module, string) {
  if (level <= LOG_LEVEL) {
    console.log(" [ " + module + " ]" + ' : ' + JSON.stringify(string));
  }
}

/**
 *
 * @param $object
 * @param info
 * @param position one of: left, top, botom, right
 */
function renderTooltip($object, info, position) {
  
  $object.attr('title', undefined);
  
  if (typeof position === 'undefined') position = 'right auto';
  
  $object.attr('data-content', info);
  $object.attr('data-html', true);
  $object.attr('data-toggle', 'popover');
  $object.attr('data-trigger', 'hover');
  $object.attr('data-placement', position);
  $object.attr('data-container', 'body');
  $object.popover();
  
}

function defineTooltipLogic(context) {
  
  var $hasTooltip = $('[data-tooltip]', context);
  
  for (var i = 0; i < $hasTooltip.length; i++) {
    var $obj = $($hasTooltip[i]);
    //console.log($obj);
    renderTooltip($obj, $obj.attr('data-tooltip'), $obj.attr('data-tooltip-position'));
  }
  
  return true;
}

// Returns a function, that, as long as it continues to be invoked, will not
// be triggered. The function will be called after it stops being called for
// N milliseconds. If `immediate` is passed, trigger the function on the
// leading edge, instead of the trailing.
function debounce(func, wait, immediate) {
  var timeout;
  return function () {
    var context = this, args = arguments;
    var later   = function () {
      timeout = null;
      if (!immediate) func.apply(context, args);
    };
    var callNow = immediate && !timeout;
    clearTimeout(timeout);
    timeout = setTimeout(later, wait);
    if (callNow) func.apply(context, args);
  };
}

// Allow callback to run at most 1 time per $limit ms
function throttle(callback, limit) {
  var wait = false;                  // Initially, we're not waiting
  return function () {               // We return a throttled function
    if (!wait) {                   // If we're not waiting
      callback.call();           // Execute users function
      wait = true;               // Prevent future invocations
      setTimeout(function () {   // After a period of time
        wait = false;          // And allow future invocations
      }, limit);
    }
  }
}
//
//function defineStickyNavsLogic() {
//  var $sticky = $('.sticky');
//  var $body =  $('body');
//  var $page = $('#page-content-wrapper');
//
//  var bodyColor = $body.css('background-color');
//
//  if (bodyColor === 'rgba(0, 0, 0, 0)' || bodyColor === 'rgb(255, 255, 255)') {
//    bodyColor = 'white';
//  }
//
//  var mainPanel = $('nav.navbar.navbar-inverse.navbar-fixed-top');
//  var mainPanelHeight = mainPanel.height();
//
//  var pageWidth = $page.width();
//  $body.on('resize', function(){
//    'use strict';
//    pageWidth = $page.width();
//  });
//
//  function stick($element, offsetTop) {
//
//    if (!$element.hasClass('fixed') && window.screen.availHeight > 10 * offsetTop) {
//      $element.addClass("fixed text-center");
//      var backCol = $element.css('background-color');
//      $element.data('old-background', $element.css('background-color'));
//
//      if (backCol === 'rgba(0, 0, 0, 0)' || backCol === 'transparent') {
//        backCol = bodyColor;
//      }
//
//      $element.css({
//        position: 'fixed',
//        top: mainPanelHeight + offsetTop,
//        'background-color': backCol,
//        'z-index': 200,
//        border: '1px solid silver',
//        width: pageWidth
//        //'margin-left' : 'auto',
//        //'margin-right' : 'auto'
//      });
//    }
//  }
//
//  function unStick($element) {
//    if ($element.hasClass('fixed')) {
//      $element.removeClass("fixed");
//      $element.css(
//        {
//          position: 'relative',
//          top: '',
//          'background-color': $element.data('old-background'),
//          'z-index': 100,
//          'border': '',
//          width: ''
//        }
//      );
//    }
//  }
//
//
//  function checkToStick($element, position, offsetTop) {
//    var wrapper = $(document);
//
//    wrapper.on('scroll', function(event) {
//
//      var pageYOffset = window.pageYOffset;
//
//      if (pageYOffset == 0) {
//        unStick($element);
//      }
//      else {
//
//        throttle(function () {
//          var shouldBeSticked = (pageYOffset != 0)
//              && (pageYOffset + offsetTop + mainPanelHeight + $element.outerHeight() > position);
//
//          shouldBeSticked ? stick($element, offsetTop) : unStick($element);
//        }, 100)();
//
//      }
//
//    });
//
//    return $element.outerHeight();
//  }
//
//  var sum = 0;
//  $.each($sticky, function (i, element) {
//    var $element = $(element);
//    //here checkToStick() returns height of $element, so every next element knows its relative position
//    sum += checkToStick($element, $element.offset().top, sum);
//  });
//}

function defineNavbarFormLogic(context) {
  'use strict';
  var $navbarForms = $('form.navbar-form:not(.no-live-select)', context);
  $.each($navbarForms, function (i, form) {
    var $form = $(form);
    
    $.each($form.find('select'), function (j, select) {
      $(select).on('change', function () {
        $form.submit();
      });
    });
    
  });
}

function defineAutoSubmitSelect(context) {
  var $autoSubmitted = $('select[data-auto-submit]', context);
  
  if ($autoSubmitted.length > 0) {
    $autoSubmitted.on('change', function () {
      var $this  = $(this);
      var params = $this.attr('data-auto-submit');
      
      if (params === 'form') {
        $this.closest('form').submit();
        return true;
      }
      else {
        var name  = $this.attr('name');
        var value = $this.val();
        location.replace('?' + params + '&' + name + '=' + value);
      }
    })
  }
  
}

function defineFileInputLogic(context) {
  
  $('.file-input', context).each(function (i, e) {
    'use strict';
    var $this = $(e);
    
    var $visible_file = $this.find('.file-visible');
    var $hidden_file  = $this.find('.file-hidden');
    
    if ($visible_file.val()) {
      $visible_file.click(function () {
        window.open($visible_file.attr('data-url'), '_blank');
      });
    }
    
    $hidden_file.on("change", function () {
      // Remove onclick listener
      $visible_file.off('click');
      
      // Extracting filename from path
      var full_name_path = $hidden_file.val();
      var real_name      = full_name_path;
      
      var matched = full_name_path.match('(?:.+\\\\)*(.+)$');
      if (matched.length > 0) {
        real_name = matched[1];
      }
      
      $visible_file.val(real_name);
      $visible_file.css("font-weight", "bold");
    });
  });
}

function setBoxRefreshingState($box, state){
  if (state === true) {
    var refresh_block = jQuery('<div></div>', {'class': 'overlay'}).html(
        jQuery('<i></i>', {'class': 'fa fa-refresh fa-spin'})
    );
    $box.append(refresh_block);
  }
  else {
    $box.find('div.overlay').remove();
  }
}

function initUpButton() {
  
  var $btn = $('<a/>', {id: 'up-btn', role: 'button', style: 'display : none'});
  $btn.html($('<span/>', {'class': 'glyphicon glyphicon-chevron-up up-btn-icon'}));
  
  var lastPosition             = false;
  var onClickShouldScrollToTop = true;
  var buttonVisible            = false;
  
  var setToTop = function () {
    console.log('setToTop');
    // Clear last position
    lastPosition = false;
    
    // Set flag indicating action
    onClickShouldScrollToTop = true;
    
    // Change icon
    $btn.find('span')
        .removeClass('glyphicon-chevron-down text-yellow')
        .addClass('glyphicon-chevron-up');
  };
  
  var setToLast = function () {
    console.log('setToLast');
    
    lastPosition = window.pageYOffset || document.documentElement.scrollTop;
    
    // Clear flag indicating action
    onClickShouldScrollToTop = false;
    
    
    // Change icon
    $btn.find('span')
        .removeClass('glyphicon-chevron-up')
        .addClass('glyphicon-chevron-down text-yellow');
  };
  
  $btn.on('click', function (e) {
    cancelEvent(e);
    
    if (onClickShouldScrollToTop) {
      setToLast();
      window.scrollTo(0, 0);
    }
    else if (lastPosition) {
      window.scrollTo(0, lastPosition || 0);
      setToTop();
    }
  });
  
  $(window).scroll(function () {
    
    var currentScroll = window.pageYOffset || document.documentElement.scrollTop;
    
    // Show button only if under first 300px, or was returned from top and can return
    if (currentScroll > 300) {
      if (!onClickShouldScrollToTop && lastPosition) setToTop();
      
      if (!buttonVisible) {
        buttonVisible = true;
        $btn.fadeIn();
      }
    }
    else {
      if (onClickShouldScrollToTop && buttonVisible) {
        buttonVisible = false;
        $btn.fadeOut();
      }
    }
  });
  
  $('body').prepend($btn);
}

function getOffset(el) {
  var _x = 0;
  var _y = 0;
  while (el && !isNaN(el.offsetLeft) && !isNaN(el.offsetTop)) {
    _x += el.offsetLeft - el.scrollLeft;
    _y += el.offsetTop - el.scrollTop;
    el = el.offsetParent;
  }
  return {top: _y, left: _x};
}

function defineFullWidthSelect(context) {
  var $horizontal_selects = $('.form-horizontal', context).not('.form-main').find('select').not('.normal-width');
  
  $horizontal_selects.on('chosen:showing_dropdown', function (event, params) {
    var $dropdown = params.chosen.dropdown;
    
    // Defining desired width
    var $form_group      = $dropdown.parents('.form-group').first();
    var form_group_width = $form_group.width();
    
    // Count left offset
    var form_group_offset = getOffset($form_group[0]);
    var dropdown_offset   = getOffset($dropdown[0]);
    
    var left_offset = form_group_offset.left - dropdown_offset.left;
    
    //Applying new CSS
    $dropdown.css({width: form_group_width, left: left_offset});
    
    // Discarding CSS changes on closeNsrt
    $(params.chosen.form_field).on('chosen:hiding_dropdown', function () {
      $dropdown.css({width: '', left: ''});
    });
  });
}

function hideHidden(context) {
  $('[data-visible]', context).each(function (i, e) {
    var $e = $(e);
    $e.data('visible') ? $e.css({'display': 'block'}) : $e.css({'display': 'none'});
  });
  $('[data-hidden]', context).each(function (i, e) {
    var $e = $(e);
    $e.data('hidden') ? $e.css({'display': 'none'}) : $e.css({'display': 'block'});
  });
}

function checkCheckboxes(context) {
  $('[data-checked]', context).each(function (i, e) {
    var $e = $(e);
    $e.prop('checked', $e.data('checked'));
  });
}

function initDatepickers(context) {
  
  if (typeof($(document).datepicker) === 'undefined') {
    return false;
  }
  
  var $datetimepickers  = $('div.datetimepicker', context);
  var $daterangepickers = $('input.date_range_picker', context);
  
  //Date picker
  $('input.datepicker', context).datepicker({
    autoclose     : true,
    format        : 'yyyy-mm-dd',
    startDate     : '-100y',
    todayHighlight: true,
    clearBtn      : true,
    forceParse    : false,
    weekStart     : 1
  })
      .on('show', cancelEvent)
      .on('hide', cancelEvent);
  
  $('input.timepicker', context).timepicker({
    showMeridian: false,
    defaultTime : false,
    explicitMode: false,
  });
  
  if ($datetimepickers.length) {
    
    $.each($datetimepickers, function (i, e) {
      var $group = $(e);
      
      var $datepart = $group.find('input.datepicker');
      var $timepart = $group.find('input.timepicker');
      var $hidden   = $group.find('input.datetimepicker-hidden');
      
      var $linked_form = ($hidden.attr('form')) ? $('form#' + $hidden.attr('form')) : $group.parents('form').first();
      
      $linked_form.on('submit', function () {
        
        $datepart.prop('disabled', true);
        $timepart.prop('disabled', true);
        $hidden.val($datepart.val() + ' ' + $timepart.val());
      })
    })
  }
  if ($daterangepickers.length) {
    
    var ranges                                     = {};
    ranges[DATERANGEPICKER_LOCALE['Today']]        = [moment(), moment()];
    ranges[DATERANGEPICKER_LOCALE['Yesterday']]    = [moment().subtract(1, 'days'), moment().subtract(1, 'days')];
    ranges[DATERANGEPICKER_LOCALE['Last 7 Days']]  = [moment().subtract(6, 'days'), moment()];
    ranges[DATERANGEPICKER_LOCALE['Last 30 Days']] = [moment().subtract(29, 'days'), moment()];
    ranges[DATERANGEPICKER_LOCALE['This Month']]   = [moment().startOf('month'), moment().endOf('month')];
    ranges[DATERANGEPICKER_LOCALE['Last Month']]   = [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')];
    
    $.each($daterangepickers, function (i, e) {
      var $e = $(e);
      
      var with_time                    = $e.hasClass('with-time');
      DATERANGEPICKER_LOCALE['format'] = (with_time) ? 'YYYY-MM-DD hh:mm' : 'YYYY-MM-DD';
      
      var has_hidden = $e.data('has-hidden');
      var callback   = undefined;
      
      if (has_hidden) {
        callback = function (start, end) {
          $e.parent().find('input[type="hidden"]#' + $e.data('name1')).val(moment(start).format(DATERANGEPICKER_LOCALE['format']));
          $e.parent().find('input[type="hidden"]#' + $e.data('name2')).val(moment(end).format(DATERANGEPICKER_LOCALE['format']));
        }
      }
      
      $e.daterangepicker({
        timePicker          : with_time,
        timePicker24Hour    : true,
        locale              : DATERANGEPICKER_LOCALE,
        autoApply           : true,
        autoUpdateInput     : true,
        showCustomRangeLabel: true,
        alwaysShowCalendars : true,
        ranges              : ranges
      }, callback);
    });
    
  }
  
}

function initChosen(context) {
  if (typeof(CHOSEN_PARAMS) === 'undefined') {
    return false
  }
  var $selects = $('select:not(#type)', context);
  
  $selects.chosen(CHOSEN_PARAMS);
  
  // Make selects that would be opened outside body open to up
  $selects.on('chosen:showing_dropdown', function (event) {
    setTimeout(function(){
      var $select = $(event.target);
      var $chosen_container = $select.next();
  
      var top = $chosen_container.offset().top,
          sctop = $(this).scrollTop(),
          winh = $(this).height(),
          y = top - sctop - winh + 100;
      
      if (y > 0 || -y > winh) {
        $select.addClass('chosen-up');
      }
      
    }, 100);
    
  });
  
  $selects.on('chosen:hiding_dropdown', function(event){
    $(event.target).removeClass('chosen-up');
  })
  
}

function openModals(context) {
  $('div.modal[data-open="1"]', context).first().modal('show');
}

function moveCalloutsToTop() {
  $('section.content').prepend($('div.callout-to-top').detach().removeClass('hidden'));
}

function defineAjaxSubmitForms(context) {
  var $ajaxSubmittedForms = $('form.ajax-submit-form', context);
  
  // Make function global
  window['ajaxFormSubmit'] = function (e) {
    cancelEvent(e);
    var $form    = $(this);
    var formData = new FormData(this);
    formData.append('AJAX', 1);
    formData.append('json', 1);
    formData.append('MESSAGE_ONLY', 1);
    formData.append('header', 2);
    
    // Replace index to qindex to allow JSON iteraction
    var index = formData.get('index');
    if (index) {
      formData.set('qindex', index);
      if (typeof formData['delete'] !== 'undefined') {
        formData['delete']('index');
      }
      else {
        formData.set('index', '');
      }
    }
    console.log(formData);
  
    //var $submitters = $form.find('button,input[type="submit"]');
    //$submitters.addClass('disabled');
    
    jQuery.ajax({
      url        : $form.attr('action') || '/admin/index.cgi',
      type       : $form.attr('method') || 'POST',
      data       : formData,
      contentType: $form.attr('enctype') || false,
      cache      : false,
      processData: false,
      success    : function (result) {
        displayJSONTooltip(result);
        
        var form_id = $form.attr('id') || $form.attr('name');
        
        Events.emit('AJAX_SUBMIT.' + form_id, result);
        Events.emit('AJAX_SUBMIT', {FORM: form_id, RESULT: result});
      },
      fail       : function (error) {
        aTooltip.displayError(error);
      },
      complete   : function () {
        //$submitters.removeClass('disabled');
      }
    });
  };
  
  if ($ajaxSubmittedForms.length) {
    $ajaxSubmittedForms.on('submit', window['ajaxFormSubmit'])
  }
}
//function initInputMask(){
//  var $masked = $('[data-inputmask]');
//
//  $masked.inputmask({"removeMaskOnSubmit" : true, mask : ''});
//  //$masked.inputmask('setvalue');
//
//}

function initFavicon() {
  $.getScript('/styles/default_adm/js/tinyco.min.js', function () {
    var badge = 0;
    var set_value = function(new_value){
      ( new_value <= 0 )
        ? Tinycon.setBubble('')
        : ( new_value > 100 )
            ? Tinycon.setBubble('99+')
            : Tinycon.setBubble(new_value);
    };
    Events.on('favicon.set', set_value);
    Events.on('favicon.clear', function () {set_value(0)});
    Events.on('favicon.increment', function () { set_value(++badge) });
    Events.on('favicon.decrement', function () { set_value(--badge)});
    Events.on('favicon.request', function () {Events.emit('favicon.responce', badge)});
    Events.emit('favicon.ready');
  });
}

function initTableMultiselectActions(context){
 var table_panels = $('div.table-action-panel', context);
 if (!table_panels.length) return false;
 
 table_panels.each(function(i, table_panel){
   var $table_panel   = $(table_panel);
  
   // Collect all checkboxes we should listen for
   var params        = [];
   var param_buttons = [];
  
   var param_name = $table_panel.data('param');
   if (typeof (param_name) === 'undefined'){
     return true;
   }
  
   if (typeof params[param_name] === 'undefined') {
     params[param_name] = $('input:checkbox[id="' + param_name + '"]');
   }
  
   var submit_action = function ($button, checked_elements) {
     var action     = $button.data('original-url');
     var comments   = $button.data('comments');
    
     var ids = [];
     checked_elements.each(function (i, el) {ids.push(el.value)});
    
     var link = action + '&' + param_name + '=' + ids.join(',');
    
     if (typeof(comments) !== 'undefined') {
       showCommentsModal(comments, link);
       return true;
     }
     else {
       $.redirectPost(link);
     }
   };
  
   var check_elements = function (param_name) {
     return function() {
       var checked_elements = params[param_name].filter(':checked');
  
       if (checked_elements.length > 0) {
         $table_panel.show();
         param_buttons.forEach(function (b) {
           b.off('click');
           b.on('click', function (e) {
             cancelEvent(e);
             submit_action($(this), checked_elements);
           });
         });
       }
       else {
         $table_panel.hide();
         param_buttons.forEach(function (b) {b.off('click')});
       }
     }
   };
  
   // Set listener
   // Collect params to listen and set listeners
   var event_to_listen   = 'ontablecheckboxeschange.' + param_name;
   var function_listener = check_elements(param_name);
   Events.on(event_to_listen, function_listener);

   // Init buttons
   var action_buttons = $table_panel.find('a.table-action-button');
   action_buttons.each(function (j, button) {
     var $button = $(button);
     $button.attr('href', '#');
     param_buttons.push($button);
   });
   
   // Will show panel if have selected checkboxes
   function_listener();
 });
 
}

function initMomentSpans(context){
  if (typeof window['moment'] !== 'undefined') {
    jQuery('span.moment-insert', context).each(function (i, span_) {
      var span = jQuery(span_);
      var time = span.data('value');
      if (!time) return;
      
      span.text(' ' + moment(time, 'YYYY-MM-DD hh:mm:ss').fromNow() + ' ');
      span.attr('title', time);
      span.css({
        'text-decoration'      : 'underline',
        'text-decoration-style': 'dashed'
      })
    });
    
    jQuery('span.moment-range', context).each(function (i, span_) {
      var span = jQuery(span_);
      var time = span.data('value');
      if (!time) return;
      
      span.text(' ' + moment.duration(time, 'seconds').humanize() + ' ');
      span.attr('title', time + ' s');
    })
  }
}

//document ready
function pageInit(context) {
  
  context = context || document;
  
  // init chosen
  initChosen(context);
  
  // Allow auto opening of modals
  openModals(context);
  
  moveCalloutsToTop(context);
  
  // Hide what has to be hidden, show what has to be showed
  hideHidden(context);
  
  // Simple logic for checking checkboxes
  checkCheckboxes(context);
  
  // Main comment modal initialization
  defineCommentModalLogic(context);
  
  // Because of Chosen.js we need custom logic for resetting form
  defineResetInputLogic(context);
  
  // Checking ip-inputs for IPV4 regexp
  defineIpInputLogic(context);
  
  // Checking inputs for defined regexpressions
  defineCheckPatternLogic(context);
  
  // Sticky panels that are fixed on top
  //defineStickyNavsLogic();
  
  // Auto sending navbar form
  defineNavbarFormLogic(context);
  
  // Returning 0 for unchecked chekboxes
  fixCheckboxSendValue(context);
  
  // Make autosubmittable selects work
  defineAutoSubmitSelect(context);
  
  // Define file input logic
  defineFileInputLogic(context);
  
  //Define panel-wide selects
  defineFullWidthSelect(context);
  
  // Concatenate date and time parts
  initDatepickers(context);
  
  // Called on document
  if (context == document) {
    initUpButton(document);
  }
  
  // Find and initialize all tooltips
  defineTooltipLogic(context);
  
  // Allow to use AJAX submitted forms
  defineAjaxSubmitForms(context);
  //InitInputMask
  //initInputMask();
  
  //Allow disable inputs regard to another input value
  defineLinkedInputsLogic(context);
  
  // Init table actions logic
  initTableMultiselectActions(context);
  
  initMomentSpans(context);
}

function initMultifileUploadZone(id, name_, max_files_){
  var name = name_ || 'FILE_UPLOAD';
  var max_files = max_files_ || 2;
  
  var file_zone = jQuery('#' + id);
  
  var main_input = file_zone.find('input[name='+ name +']');
  var counter_input = jQuery('<input/>', { name : name + '_UPLOADS_COUNT', type : 'hidden' });
  file_zone.append(counter_input);
  
  var counter = 0;
  var append_new_input = function(){
    counter_input.val(++counter);
    var new_input = jQuery('<input/>', {
      type : 'file',
      name : name + '_' + counter
    });
    
    new_input.data('number', counter);
    new_input.on('change', append_new_input_if_needed);
    file_zone.append(new_input);
  };
  
  var append_new_input_if_needed = function(){
    // Get this position
    var position = jQuery(this).data('number') || 0;
    
    // If is last, should append new input and counter starts from 0
    if (position === counter && counter < (max_files - 1)){
      append_new_input();
    }
  };
  
  main_input.on('change', append_new_input_if_needed);
}

function copyToBuffer(value){
  
  // Create textarea
  var $textarea = $('<textarea></textarea>')
      .text(value);
  
  // Place on page
  $('footer.main-footer').after($textarea);
  
  // Select text inside
  $textarea.select();
  
  try {
    document.execCommand('copy');
    document.getSelection().removeAllRanges();
  }
  catch (err) {
    alert('Oops, unable to copy');
  }
  finally {
    $textarea.remove();
  }
  
}

/**
 * Used to generate unique identifiers
 * @returns {string}
 */
function generate_guid(){
  return generate_s4() + generate_s4() + '-' + generate_s4() + '-' + generate_s4() + '-' +
      generate_s4() + '-' + generate_s4() + generate_s4() + generate_s4();
}
function generate_s4 (){
  return Math.floor((1 + Math.random()) * 0x10000)
      .toString(16)
      .substring(1);
}

// jquery extend function
$.extend({
  redirectPost: function (location, args_) {
    var form = '',
    args = args_ || {};
    
    if (location.indexOf('?') !== -1){
      // Deserialize link
      var deserialize = function(data){
        var splits = decodeURIComponent(data).split('&'),
            i = 0,
            split = null,
            key = null,
            value = null,
            splitParts = null;
    
        var kv = {};
        while(split = splits[i++]){
          splitParts = split.split('=');
          key = splitParts[0] || '';
          value = (splitParts[1] || '').replace(/\+/g, ' ');
          if (key !== ''){
            if( key in kv ){
              if( $.type(kv[key]) !== 'array' ){
                kv[key] = [kv[key]];
              }
              kv[key].push(value);
            }
            else{
              kv[key] = value;
            }
          }
        }
        return kv;
      };
      
      var location_args = location.split('?');
      location = location_args[0];
      args = $.extend(args, deserialize(location_args[1]));
    }
    
    $.each(args, function (key, value) {
      value = value.split('"').join('\"');
      form += '<input type="hidden" name="' + key + '" value="' + value + '">';
    });
    
    $('<form action="' + location + '" method="POST" style="display:none;">' + form + '</form>')
        .appendTo($(document.body)).submit();
  }
});

$(function () {
  pageInit(document);
  
  $('a#admin-status').on('click', function(){
    
    $.get('?get_index=msgs_admin_quick_message&header=2', function(data){
      // First check function exists
      if (! data.match(/not exist/)){
        // If data is normal, show it in modal
        loadDataToModal(data, false, true);
      }
    });
  });
});


