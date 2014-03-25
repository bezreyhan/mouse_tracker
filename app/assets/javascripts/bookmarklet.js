// window.onload = function() {
//doe thsi show up
var trackOn = true;
var coordinatesString = "";
var coordinatesArray = [];
var timeOfLoad = Date.now();
var windowLength = String(window.innerWidth -25)+"px";

document.body.innerHTML += "<div onclick=cleanCoordinatesArray() id='collectData' style='width:20px;height:20px;border:2px solid black;'></div>";
var button = document.getElementById('collectData');

document.body.innerHTML += "<div id='heatMapContainer' style='height:1000px;border:2px solid black;z-index:-500;position:absolute;top:4px;left:4px'></div>";
document.getElementById('heatMapContainer').style.width = windowLength;

var script = document.createElement('script');
script.src = 'http://localhost:3000/assets/heatmap.js';
document.body.appendChild(script);

window.onmousemove = function (event) {
  if (trackOn) {
    printMovement(event);
    trackOn = false;
  }
};

function printMovement (event) {
  coordinatesString += ("("+event.clientX+","+event.clientY+")");
  coordinatesArray.push({"x":event.clientX, "y":event.clientY});
  console.log("("+event.clientX+","+event.clientY+")");
}

mouseTrackTimer = window.setInterval(function() {
  trackOn = true;
}, 10);

//remove duplictes and set a count to each object 
//in coordinatesArray so that the data can be mapped
var cleanData = [];
function cleanCoordinatesArray(){
  for(var i=0; i<coordinatesArray.length; i++) {
    var obj = coordinatesArray[i];
    if(matchFound(obj) === false){
      var countObj = obj;
      countObj.count = 1;
      cleanData.push(countObj);
    }
  }
  console.log(coordinatesArray.length);
  console.log(cleanData.length);
  displayMap();
}

function matchFound(obj) {
  if (cleanData.length === 0) {
    return false
  } 
  else {
    for (var i=0; i<cleanData.length; i++) {
      var cleanObj = cleanData[i];
      if (obj.x === cleanObj.x && obj.y === cleanObj.y) {
        cleanObj.count += 1;
        return true;
      }
    }
    return false
  }
}

// sendCoordTimer = window.setInterval(function() {
function sendData() {
  console.log(coordinatesString);
  $.ajax({
    type: "POST",
    url: 'http://localhost:3000/interactions',
    datatType: 'json',
    data: {
      interaction: {
        move: coordinatesString
      }
    },
    success: function(response) {
      alert('works');
    }
  });
}
// 9000);

function displayMap() {
  console.log("displayMap is fired");
  var config = {
    "radius": 10,
    "element": document.getElementById("heatMapContainer"),
    "visible": true,
    "opacity": 40,
    "gradient": { 0.45: "rgb(0,0,255)", 0.55: "rgb(0,255,255)", 0.65: "rgb(0,255,0)", 0.95: "yellow", 1.0: "rgb(255,0,0)" }
  };

  var heatmap = heatmapFactory.create(config);

  heatmap.store.setDataSet({ max: 10, data: cleanData } );
}


// }