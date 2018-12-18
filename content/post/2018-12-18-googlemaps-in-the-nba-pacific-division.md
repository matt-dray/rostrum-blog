---
title: The NBA Pacific Division with gmapsdistance
author: Matt Dray
date: '2018-12-18'
slug: nba-travel
categories: []
tags: []
draft: yes
---


# The NBA 

Teams play others from their division four times per regular season.

There are two 'conference'  Western and Eastern. The conferences are each split into three divisions of five teams. You'd think that paying _within_ the division would cut journey time between games, but you'd be wrong. 

For example, the Central division is (relatively) tightly packed. It contains the Chicago Bulls, Cleveland Cavaliers, Detroit Pistons, Indiana Pacers and Milwaukee Bucks -- cities clustered by the Great Lakes.

Converesely, the Northwest Division of the Western Conference.


# Travel

The R package [`gmapsdistance`](https://github.com/rodazuero/gmapsdistance) wraps the [Google Maps](https://www.google.co.uk/maps) [API](https://medium.freecodecamp.org/what-is-an-api-in-english-please-b880a3214a82). You can use it to query origin and destination points for travel distance (metres) and duration (seconds) for several modes of travel: on foot, by car, by public transport, or by bicycle (for parts of North America only).

# Prepare the workspace

Install the packages in the form `install.packages("gmapsdistance")` and load with:

```{r packages, message=FALSE, warning=FALSE}
library(gmapsdistance)  # for getting info from the API
library(dplyr)  # for data manipulation and pipes (%>%)
```

# Get data

The [Wikipedia page for the National Basketball Association (NBA)] has a table that contains each team and their location. We need the co-ordinates from this table so we can set our origin and destination points. We can use [Hadley Wickham's `rvest` package](https://github.com/hadley/rvest) to scrape the table's HTML.

```{r}
library(dplyr)  # data manipulation
library(rvest)  # web scraping

html <- read_html("https://en.wikipedia.org/wiki/National_Basketball_Association")
table_xpath <- '//*[@id="mw-content-text"]/div/table[4]'

nba_table <-
  html_nodes(x = html, xpath = table_xpath) %>%
  html_table(fill = TRUE, header = NA) %>% 
  as.data.frame() %>%
  filter(Division == "Northwest") %>% 
  mutate(
    Search = paste(Arena, City.State),
    Search = str_replace_all(Search, ",", ""),
    Search = str_replace_all(Search, " ", "+")
  ) %>% 
  select(Team, Arena, State = City.State, Search)
```

# Get a key

https://developers.google.com/maps/documentation/distance-matrix/get-api-key#key

# Calculate distances

Create separate dataframes of postcodes for the two local authorities, then pass these to the Google Maps API with the `gmpasdistance()` function. The basic arguments to this function are the origin and destination (can be an address, postcode or latlong coordinates), the mode of travel (car, public transit, walking) and the return format (shape) of the data (each origin-destination pair per row, or a matrix). You can find more about the arguments by executing `?gmapsdistance`.

```{r gmapsdistance, cache=TRUE}
# Vectors of postcodes for each local authority

cam_pcd <- gias %>% 
  dplyr::filter(la_name == "Cambridgeshire") %>%   # only schools in this LA
  dplyr::select(postcode) %>%  # we just want postcode data
  dplyr::pull()  # pull vector from dataframe

cum_pcd <- gias %>% 
  dplyr::filter(la_name == "Cumbria") %>% 
  dplyr::select(postcode) %>% 
  dplyr::pull()

# Call the API

sch_distances <- gmapsdistance::gmapsdistance(
  origin = cam_pcd,  # start point of journey
  destination = cum_pcd,  # end point of journey
  mode = "driving",  # driving time
  shape = "long"  # format of output data (origin and destination as cols)
)
```

The output is a list of three elements (in this order:

1. Time (seconds)
2. Distance (metres)
3. Status (i.e. could the calculation be made?)

Each list element has three columns:

* `or` -- the origin point
* `de` -- the destination point
* one of `Time`, `Distance` and `Status`

Let's start with `Status`. Were all the requests actioned?

```{r status}
sch_distances$Status  # isolate status element of returned list
```

We want the status `OK`, which indicates that there were no problems and the distances were collected with no errors. The `PLACE_NOT_FOUND` error is returned in the `Status` column when Google Maps can't locate your origin or destination.

So what were the distances between the locations in metres?

```{r distance}
sch_distances$Distance  # isolate distance (metres) element of returned list
```

And how much time does this translate to, in seconds, when driving between the locations?

```{r time}
sch_distances$Time  # isolate time (seconds) element of returned list
```

That's great, but still not super-friendly to use, especially over long distances.

# Manipulate the data

Let's create a more meaningful table for our purposes. Let's say we only care about the distances for now, so we'll focus on that element of the list and join in information about the origin from the Get Information About Schools data

```{r list-to-df, warning=FALSE}
distance_info <- sch_distances$Distance %>%  # to the distance data...
  dplyr::left_join(
    y = select(
      gias, 
      establishmentname, postcode  # join these columns from the GIAS data
      ),   
    by = c("or" = "postcode")  # match on postcode values (origin)
  ) %>% 
  dplyr::left_join(   # now join...
    y = select(
      gias,  # from GIAS...
      establishmentname, postcode  # these columns
      ),
    by = c("de" = "postcode"),  # match on postcode values (destination)
    suffix = c("_or", "_de")  # add col name suffixes for origin/destination
  )

dplyr::glimpse(distance_info)  # inspect data
```

While we're at it, we can look arbitrarily at the longest distances.

```{r arrange}
distance_info %>%
  dplyr::mutate(  # create new columns
    Kilometres = round(Distance/1000, 1),  # calculate km from m
    Miles = round(Kilometres * 0.621371, 1)  # convert to miles
  ) %>% 
  dplyr::select(  # select columns to rename and retain
    Origin = establishmentname_or,
    Destination = establishmentname_de,
    `Kilometres`,
    `Miles`
    ) %>% 
  dplyr::arrange(desc(Kilometres)) # arrange by longest distance first
```

