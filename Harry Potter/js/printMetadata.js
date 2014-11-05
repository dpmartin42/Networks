// Print metadata in the slider by looping through the 
// links in the clean metadata file

function printMetadata(node_object){

	document.getElementById("slider").innerHTML =

	"<p align='center'><img src='" + node_object.link_image + "'alt='Stuff' style='width: 40%; height: 40%'>" 
	
	document.getElementById("slider").innerHTML +=
	
	"<p align='center'; style='font-family:HarryPotter; font-size:150%'><a class='iframe' href='http://harrypotter.wikia.com/wiki/" + node_object.link + "'>" + node_object.label + "</a>"
	
	document.getElementById("slider").innerHTML += "<h1 style='font-family:HarryPotter' align='center'><b>Connections: </b></p>"
	
	for (var i = 0; i < node_object.connection_label.length; i++) {
        
    		document.getElementById("slider").innerHTML += 
    		"<p align='center'><a class='iframe' href='http://harrypotter.wikia.com/wiki/" + node_object.connection_link[i] + "'>" + node_object.connection_label[i] + "</a>"   
    		
    }
    
}



