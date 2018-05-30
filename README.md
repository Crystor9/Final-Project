# Final Project For Info 201

`Previous Idea`

## Project Description

We’ll be working with **Spotify API**, which provides access to user related data, such as playlists and user profile information. Such access is enabled through selective authorization, by the user. We can access the dataset on Spotify for Developers. What’s more, the API allows developers to get the user's Currently Playing Track, so developers can get a sense of the users’ **music preferences** in different time periods. It also allows developers to learn about users’ profiles so developers can analyze the music data and associate it with locations.

The **target audience** of our project is **college student**. A large user group of Spotify is comprised of college students and it would be interesting to see if there is any  **association** between their music habits and universities they are studying in.

**3 specific questions** our project will answer for the audience are:
- **How long** does the audience stay listening to music on Spotify when he/she starts to listen?
- What kind of **genres** does the audience listen to in the morning, afternoon and evening?
- Do **listening habits** of students from various **universities** differ?


## Technical Description

We will be reading in the data using an **API**.

The types of **data-wrangling** we will need to do include:
 - Take the data that is in JSON format returned from the API and extract the body that contains the actual contents using the content() method from the data, then further convert the JSON data into `R` data structure that we can use, such as data frame, using the `jsonlite` library. We might also need to **flatten the data** because we are most likely to have lists within lists. We will probably need to join different data frames together if they share the same columns to avoid confusion on using many different data frames, it would also be easier for us to organize the data
 - If there is any **unusual data**,  we will need to treat it differently than other data. For example, if there are any missing or null values, we will need to remove them to avoid miscalculations or other errors it will cause us to encounter
 - Filter data returned to a subset of data that we are most interested in working with and group the data by different conditions



Major **libraries** we will be using include:
- `httr` and `jsonlite` to work with http connections and read and create JSON data tables
- `plotly` to build interactive maps/charts
- `shiny` to build interactive websites
- `ggplot2` to plot static charts and make graphics
- `RColorBrewer` to display different colors for plots/charts

Major **challenges** we are expecting to encounter will probably include:
- **Data-wrangling**, since data will not always be structured in a perfect way, especially when the data set is relatively large and is taken down from the internet. We will need to filter down the data, group it by different conditions and fix any unusual data.
- We are also expecting to see failures when collaborating with others in the team in the process of **pulling and merging** existing data, as well as learning to read error messages and fix them
- We are also expecting to see challenges when working on **different branches**. The process involves creating and switching to different new branches, undoing changes, as well as merging different branches together, and there will be merging conflicts that we will most likely to encounter and resolve when working on the project with other team members

---
`New Idea (Current Version)`

## Project Overview
The website uses data drawn from **Spotify** and provides plots and tables displaying the **top 10 tracks** and **related artists** upon selecting individual artist and year range. The purpose of this website is to visualize how artists are categorized and connected to each other and how tracks of different artists are rated on a digital music service like Spotify.

## Audience
Music is loved and heard by the majority of the population in this world. Inevitably some tunes tend to be loved and heard numerous times. Our targeted audience are **those who love popular tunes and artists, who can search up some top tracks and find artists similar to their favorite ones using our web app**.

## Data
We worked with **2 libraries** for this website from the **Spotify** libraries. The top track library returns a list of information about the top 10 tracks of the selected artist, which we selected some features to be used in the visualizations. The other library returns data of artists who are similar to the selected artist. The Spotify libraries can be found here: [Spotify API Libraries](https://beta.developer.spotify.com/console/)

## Questions
Some questions that can be answered using our data included:

* For a particular artist, which track has the highest popularity out of the top 10 tracks?
* Who are some of the artists that are similar to Taylor Swift on Spotify? (based on the community's listening history)
* How many tracks were released from years 2015 to 2017?

## Structure
The next 2 tabs display varied visualizations with respect to the Spotify data. The **first tab** displays Top Tracks by a particular artist within a time period range according to the user. The **second tab** allows the user to find artists similar to their favorite ones based on certain factors like popularity or number of followers, which then can be viewed by the user.

## Project Creators
* Christie Zhao
* Jiajun Li
* Ranjith Ramkishore
* Yin Chen
