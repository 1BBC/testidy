function build_construct(Param_flors, Param_entrances, Param_rooms, elem_id, user_info, lang_pack, min_height, flats_sum) {
  
  var status_colors        = ['#79f229', "#ed4a3b", '#FF7A45', '#009D00', '#FF8000', '#9b9b9b'];
  var status_colors_window = ["#0000FF", '#0000FF', '#824227', '#009D00', '#FF8000'];
//Primitiv param
  var scale                = 60;
  var room_width           = scale;
  var room_higth           = scale * 0.6;
  var window_width         = scale * 0.3;
  var window_higth         = scale * 0.3;
  var door_width           = scale * 0.5;
  var door_higth           = scale * 0.5;
//Primitiv
  var build_window;
  var invis;
  var dor;
  var floor;
  var build_line;
  
  var tip     = $("#tip").hide();
  var tipText = "";
  var over    = false;
  
  var padding         = +scale;
  var rooms           = Param_rooms * room_width;
  var line_width      = 6;
  var entrances_width = Param_rooms * room_width / 2 - room_width;
  var dor_num         = 0;
  var room_id         = 1;
  var flat_score      = 1;
  var d               = 0;
  var timeeqel;
  var canvas_width    = jQuery('#canvas_container').prop("clientWidth");
  var paper_height    = (Param_flors * room_higth + padding) < min_height ? min_height : Param_flors * room_higth + padding;
  var paper_width     = (room_width * Param_rooms * Param_entrances + padding) < canvas_width ? canvas_width : (room_width * Param_rooms * Param_entrances + padding);
  var build_x         = 0;
  var user_info       = JSON.parse(user_info);
  var lang_pack       = JSON.parse(lang_pack);
  if ((room_width * Param_rooms * Param_entrances + padding) < canvas_width) {
    build_x = canvas_width / 2 - ((rooms * Param_entrances) / 2) - room_width;
  }
  else {
    build_x = room_width * Param_rooms * Param_entrances + padding / 2 - (rooms * Param_entrances) - room_width;
  }
  var build_y = paper_height;
  
  var paper     = new Raphael(
      document.getElementById(elem_id),
      paper_width,
      paper_height
  );
  var backgroud = paper
      .rect(0, 0, paper_width, paper_height)
      .attr({
        fill  : '#78E5EA',
        stroke: 'none'
      });
  
  /*$('#build_range_zoom').attr({min:min_height, max:Param_flors * room_higth + padding});
   
   $('#build_range_zoom').click(function(){
   var zoom_value = $('#build_range_zoom').val();
   paper.setViewBox(0, 0, zoom_value, zoom_value);
   })
   */
// Hover function
  var hoverIn = function () {
    this.attr({
      'fill-opacity': 0.5,
      fill          : 'yellow',
      'stroke-width': 1,
      'stroke'      : 'white'
    });
  };
  
  var hoverOut = function () {
    this.attr({
      'fill-opacity': 0.0,
      fill          : 'yellow',
      cursor        : 'pointer',
      'stroke'      : 'none'
      
    });
  };
  
  $(document).mousemove(function (e) {
    if (over) {
      tip.css("left", e.clientX - 70).css("top", e.clientY - (52 + tip.height() / 2));
      tip.html(tipText);
    }
  });
  
  function addTip(node, txt) {
    $(node).mouseenter(function () {
      tipText = txt;
      tip.show();
      over = true;
    }).mouseleave(function () {
      tip.hide();
      over = false;
    });
  }
  
  var timeeqel;
  var d = 1;
  for (var e = 0; e <= Param_entrances - 1; e++) {
    var x_d = (room_width * Param_rooms) * e;
    
    for (var r = 0; r <= Param_rooms - 1; r++) {
      
      floor = paper.rect(build_x + x_d + room_width + (room_width * r), build_y - room_higth, room_width, room_higth).attr({
        fill  : '#E3FAFA',
        stroke: 'none'
      });
    }

    for (var f = 2; f <= Number(Param_flors) + 1; f++) {
      var y_d = room_higth * f;
      
      for (var r = 0; r < Param_rooms; r++) {
        flat_score = d++;
        var fill_status_color;
        
        if (typeof (user_info[flat_score]) !== 'undefined') {

          if (user_info[flat_score]['disable'] === 1) {
            fill_status_color = status_colors[1]
          }
          else if (user_info[flat_score]['creditor'] === 1) {
            fill_status_color = status_colors[2]
          }
          else if (user_info[flat_score]['debetor'] === 1) {
            fill_status_color = status_colors[3]
          }
          else {
            fill_status_color = status_colors[0]
          }
          var addTipStroukc = lang_pack['FLAT'] + ' ' + user_info[flat_score]['address_flat'] + '<br/>' + user_info[flat_score]['fio'];
          floor             = paper
              .rect(build_x + x_d + room_width + (room_width * r), build_y - y_d, room_width, room_higth)
              .attr({
                fill  : fill_status_color,
                stroke: 'none'
              });
        }
        
        else {
          var addTipStroukc = lang_pack['FLAT'] + ' ' + flat_score;
          
          
          floor = paper
              .rect(build_x + x_d + room_width + (room_width * r), build_y - y_d, room_width, room_higth)
              .attr({
                fill  : 'white',
                stroke: 'none'
              });
          
        }
        
        
        timeeqel = room_width * r;
        var window_status_color;
        if (flats_sum < (d - 1)) {
          window_status_color = status_colors[5];
        }
        else {
          window_status_color = '#78E5EA';
        }
        
        build_window = paper.rect(build_x + x_d + room_width + window_width + timeeqel + (window_higth / 5), build_y - y_d + window_higth / 2, window_width, window_higth).attr({
          fill  : window_status_color,
          stroke: 'none'
        });
        
        var flat_num = paper.text(build_x + x_d + room_width + window_width + timeeqel + (window_higth / 1.5 ),
            build_y - y_d + window_higth, flat_score).attr({
          'font-size'  : 12,
          'font-weight': 900,
          'fill'       : '#133177'
        });
        
        invis = paper.rect(build_x + x_d + room_width + (room_width * r), build_y - y_d, room_width, room_higth).attr({
          'fill-opacity': 0.0,
          fill          : 'yellow',
          cursor        : 'pointer',
          'stroke'      : 'none'
          
        });
        
        invis.hover(hoverIn, hoverOut, invis, invis);
        addTip(invis.node, addTipStroukc);
      }
    }
    dor_num++;
    
    dor = paper.rect(build_x + (x_d - (entrances_width + door_width / 2) + room_width * Param_rooms), build_y - door_higth, door_width, door_higth).attr({
      fill  : '#7DCAFA',
      stroke: 'none'
    });
    
    build_line = paper.path("M" + (build_x + x_d + room_width + room_width * Param_rooms) + "," + (build_y - Param_flors * room_higth - room_higth) + " L" + (build_x + x_d + room_width + room_width * Param_rooms) + "," + (build_y) + " z").attr({
      'stroke'      : '#78E5EA',
      'stroke-width': line_width + 'px'
    });
    
    var t = paper.text(build_x + x_d - (entrances_width) + room_width * Param_rooms, build_y - door_higth / 2, dor_num).attr({
      'font-size'  : 14,
      'font-weight': 900,
      'fill'       : 'white'
    });
  }
}