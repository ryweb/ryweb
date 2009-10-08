// tooltip widget
function positionTooltip(event, element){
var __x = Event.pointerX(event);
  var __y = Event.pointerY(event);
  //alert(__x+","+__y);
  element.style.position = 'absolute'
  element.style.top = __y - 170 + 'px';  
  element.style.left = __x - 265 + 'px';
}

function toggleTooltip(event, element) { 
  positionTooltip(event, element);
  element.toggle();
}

function showTooltip(event, element) { 
  positionTooltip(event, element);
  element.show();
}

function hideTooltip(event, element) { 
  positionTooltip(event, element);
  element.hide();
}
// tooltip widget
function toggleTooltip(event, element) { 
  var __x = Event.pointerX(event);
  var __y = Event.pointerY(event);
  //alert(__x+","+__y);
  element.style.top = __y + 5;  
  element.style.left = __x - 40;
  element.toggle();
}
