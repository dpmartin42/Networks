Interactive Networks Using Sigma.js
---

This repo houses two network visualizations using sigma.js:

* Hello World: A simple graph drawing with an autocomplete search tool, buttons for direction and zoom navigation, as well as a checkbox to toggle colors. 
* Les Mis: The same framework as Hello World, except it reads in a separate .json file after force-directed layout and community detection pre-processing. As such, the checkbox toggles community detection rather than changing colors. 

#### Installation / Try this out at home

1. Clone this repo

2. CD into the Hello_World directory

3. Run the following command:

 ```
python -m SimpleHTTPServer
 ```

Visit [http://localhost:8000](http://localhost:8000) and test the application
