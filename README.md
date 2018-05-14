# Final-Project For Info 201

## Technical Description

We will be reading in the data using an **API**.

The types of **data-wrangling** we will need to do is to take the data that is in JSON format returned from the API and extract the body that contains the actual contents using the content() method from the data, then further convert the JSON data into `R` data structure that we can use, such as data frame, using the `jsonlite` library. We might also need to flatten the data because we are most likely to have lists within lists. We will probably need to join different data frames together if they share the same columns to avoid using many different data frames, it would also be easier for us to organize the data.

Major **libraries** we will be using include:
* `httr` and `jsonlite` to work with http connections and read and create JSON data tables
* `plotly` to build interactive map/chart
* `shiny` to build interactive website
- `ggplot2` to plot static charts and make graphics

Major **challenges** we are expecting to encounter will probably include:
* **Data-wrangling**, since data will not always be structured in a perfect way, especially when the data set is relatively large and is taken down from the internet. We are also expecting to see failures when collaborating with others in the team in the process of pulling and merging existing data, as well as learning to read error messages and fix them.
* We are also expecting to see challenges when working on **different branches**. The process involves creating and switching to new branches, undoing changes, as well as merging different branches together, and there will be merging conflicts that we will most likely to encounter and resolve when working on this project with other team members.
