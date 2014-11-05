Interactive Networks Using Sigma.js
---

This repo houses three network visualizations using sigma.js:

* Hello World: A simple graph drawing with an autocomplete search tool, buttons for direction and zoom navigation, as well as a checkbox to toggle colors. 
* Les Mis: The same framework as Hello World, except it reads in a separate .json file after force-directed layout and community detection pre-processing. As such, the checkbox toggles community detection rather than changing colors. 
* Harry Potter: A more complex framework visualizing 178 characters from the Harry Potter Universe. The relevant R-code for this project is included in the project's data folder, which will take a list of Harry Potter names and links and scrape the character's image and their connections with other characters from a Harry Potter wiki website.

#### Installation / Try this out at home

1. Clone this repo

2. CD into the Hello_World directory

3. Run the following command:

```
python -m SimpleHTTPServer
```

Visit [http://localhost:8000](http://localhost:8000) and test the application
