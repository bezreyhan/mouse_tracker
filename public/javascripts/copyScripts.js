
var trackOn = true;
var coordinatesString = "";
var timeOfLoad = new Date();
var windowLength = String(window.innerWidth -25)+"px";
var bodyHeight = String(document.body.scrollHeight)+"px";
var mouseTrackerUserId;

window.onmousemove = function (event) {
  if (trackOn) {
    printMovement(event);
    trackOn = false;
  }
};

function printMovement (event) {
  coordinatesString += (event.pageX+","+event.pageY+";");
  console.log("("+event.pageX+","+event.pageY+")");
}

mouseTrackTimer = window.setInterval(function() {
  trackOn = true;
}, 10);


sendCoordTimer = window.setInterval(function sendData() {
  console.log(coordinatesString);
  $.ajax({
    type: "POST",
    url: 'http://mousemapper.herokuapp.com/interactions',
    datatType: 'jsonp',
    data: {
      interaction: {
        move: coordinatesString,
        user_id: mouseTrackerUserId,
        time: timeOfLoad,
        url: document.URL,
        window_width: windowLength,
        body_height: bodyHeight
      }
    },
    success: function(response) {
      alert('works');
    }
  });
}, 9000);

function displayMap() {
  console.log("displayMap is fired");
  var config = {
    "radius": 50,
    "element": document.getElementById("heatMapContainer"),
    "visible": true,
    "opacity": 100,
    "gradient": { 0.45: "rgb(0,0,255)", 0.55: "rgb(0,255,255)", 0.65: "rgb(0,255,0)", 0.95: "yellow", 1.0: "rgb(255,0,0)" }
  };
  var heatmap = heatmapFactory.create(config);
  heatmap.store.setDataSet({ max: 10, data: cleanData } );
  //change z-index inorder to make the heatMap the first layer
  document.getElementById("heatMapContainer").style.zIndex="1";
}
