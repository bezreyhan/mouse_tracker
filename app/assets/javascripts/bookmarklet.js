
var trackOn = true;
var coordinatesString = "";
var coordinatesArray = [];
var timeOfLoad = Date.now();
var windowLength = String(window.innerWidth -25)+"px";
var bodyHeight = String(document.body.scrollHeight)+"px";

document.body.innerHTML += "<div onclick=cleanCoordinatesArray() id='collectData' style='width:20px;height:20px;border:2px solid black;'></div>";

document.body.innerHTML += "<div id='heatMapContainer' style='z-index:-1;height:1000px;border:2px solid black;position:absolute;top:4px;left:4px'></div>";
document.getElementById('heatMapContainer').style.width = windowLength;
document.getElementById('heatMapContainer').style.height = bodyHeight;

window.onmousemove = function (event) {
  if (trackOn) {
    printMovement(event);
    trackOn = false;
  }
};

function printMovement (event) {
  coordinatesString += ("("+event.pageX+","+event.pageY+")");
  coordinatesArray.push({"x":event.pageX, "y":event.pageY});
  console.log("("+event.pageX+","+event.pageY+")");
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
    return false;
  }
  else {
    for (var i=0; i<cleanData.length; i++) {
      var cleanObj = cleanData[i];
      if (obj.x === cleanObj.x && obj.y === cleanObj.y) {
        cleanObj.count += 1;
        return true;
      }
    }
    return false;
  }
}

sendCoordTimer = window.setInterval(function() {
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
