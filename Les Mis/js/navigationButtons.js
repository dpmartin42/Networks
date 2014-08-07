var c = s.camera;

$(document).ready(function(){
  $(".move-right").bind("click",function(){
      c.goTo({
         x:c.x - 50, y:c.y
      });     
  });
});

$(document).ready(function(){
  $(".move-left").bind("click",function(){
      c.goTo({
         x:c.x + 50, y:c.y
      });     
  });
});

$(document).ready(function(){
  $(".move-up").bind("click",function(){
      c.goTo({
         x:c.x, y:c.y + 50
      });     
  });
});

$(document).ready(function(){
  $(".move-down").bind("click",function(){
      c.goTo({
         x:c.x, y:c.y - 50
      });     
  });
});

$(document).ready(function(){
  $(".zoom-in").bind("click",function(){
      c.goTo({
          ratio: c.ratio / c.settings('zoomingRatio')
      });
  });
});

$(document).ready(function(){
  $(".zoom-out").bind("click",function(){
      c.goTo({
          ratio: c.ratio * c.settings('zoomingRatio')
      });
  });
});

$(document).ready(function(){
  $(".refresh").bind("click",function(){
      c.goTo({
          x:0, y:0, ratio: 1
      });     
  });
});