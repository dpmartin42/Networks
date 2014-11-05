#########################
# Scrape HP connections
# and clean for sigma.js

rm(list = ls())

# set working directory here with setwd() 

require(rvest)
require(jsonlite)
require(igraph)

my_data <- read.csv("HP_links.csv")

# Loop characters to:
# 1) Record the url of their image (if missing, use a missing image)
# 2) Record all character links on the given character's wiki page to record connections
# This assumes that those hyper-linked on the wiki page have a "logical connection" relevant
# to the HP universe

characters <- my_data$link
images <- c()
connections <- list()

for(i in 1:length(characters)){
  
  the_character <- characters[i]

  the_file <- url(paste0("http://harrypotter.wikia.com/wiki/", the_character))
  web_page <- readLines(the_file)
  close(the_file)
  
  # Subset page at infoboximage to get the correct picture
  
  pic_subset <- web_page[grep("infoboximage", web_page)]
  
  the_image <- html(pic_subset) %>%
    html_nodes("td a") %>%
    html_attr("href")
  
  if(length(the_image) == 0){
    
    images[i] <- "http://img1.wikia.nocookie.net/__cb20130321104030/prettylittleliars/images/d/d7/Length-unknown.png"
    
  } else{
    
    images[i] <- the_image
    
  }
  
  # Subset page at "Appearances" to remove the list at the end of each webpage, making the connections more accurate
  
  page_subset <- web_page[1:(grep("Appear[ea]nces", web_page) - 1)]
  
  suppressWarnings(mentions <- html(page_subset) %>%
                     html_nodes("p a") %>%
                     html_attr("href"))
  
  link_mentions <- mentions[grep("/wiki/", mentions)]
  link_names <- gsub(".*/wiki/", "", link_mentions)
  
  connections[[i]] <- characters[characters %in% link_names]
  
  print(paste("Connections/images for", i, "of", length(characters), "found"))

}

my_data$link_image <- images

#########################
# Create all links
#########################

my_data$id <- as.character(0:(nrow(my_data) - 1))

# Calculate edges for all character connections

connection_ids <- list()

for(i in 1:nrow(my_data)){
  
  the_node <- my_data[i, ]
  
  link_ids <- my_data[my_data$link %in% connections[[i]], ]$id
  
  connection_ids[[i]] <- data.frame(source = the_node$id, target = link_ids)
  
}

total_links <- do.call(rbind, connection_ids)

#########################
# Calculate network info
# for layout
#########################

my_net <- simplify(graph.data.frame(total_links, directed = FALSE))

node_size <- data.frame(id = names(betweenness(my_net)), size = betweenness(my_net), stringsAsFactors = FALSE)

my_data <- merge(my_data, node_size, by = "id")

# Calculate layouts

#force_layout <- layout.fruchterman.reingold(my_net)
force_layout <- layout.circle(my_net)

# plot(my_net, vertex.size=5, vertex.label=NA,layout=force_layout)

# get node coordinates

my_data$x <- force_layout[, 1]
my_data$y <- force_layout[, 2]

# get simplified edges

edges <- get.data.frame(my_net)

# get node colors

my_data$color <- "#800000"
my_data$originalColor <- "#800000"

################
# Fix structure 
# for sigma.js
################

# Create list of nodes and edges

net_data <- list()

net_data$nodes <- my_data
net_data$edges <- edges

# Add string id to edges

names(net_data$edges) <- c("source", "target")
net_data$edges$id <- as.character(0:(nrow(net_data$edges) - 1))

net_data$edges$color <- "#808080"
net_data$edges$originalColor <- "#808080"

names(net_data$nodes)[2] <- "label"
net_data$nodes$id <- as.character(net_data$nodes$id)

# Find all names and edges for each individual

connection_label <- list()
connection_link <- list()

net_data$nodes$connection_label <- c(NA)
net_data$nodes$connection_link <- c(NA)

for(i in 1:nrow(net_data$nodes)){
  
  node_id <- net_data$nodes$id[i]
  
  node_connections <- c(net_data$edges[net_data$edges$source == node_id, ]$target,
                        net_data$edges[net_data$edges$target == node_id, ]$source)
  
  connection_data <- net_data$nodes[net_data$nodes$id %in% node_connections, ]
  connection_data <- connection_data[order(connection_data$label), ]
  
  net_data$nodes[net_data$nodes$id == node_id, ]$connection_label <- list(connection_data$label)
  net_data$nodes[net_data$nodes$id == node_id, ]$connection_link <- list(connection_data$link)
  
}

# Save names for search capabilities in json

write(toJSON(net_data$nodes$label, pretty = TRUE),
      append = FALSE,
      file = "HP_names.json")

# Save clean network as a new json file

write(toJSON(net_data, pretty = TRUE),
      append = FALSE,
      file = "HP_network_clean.json")





