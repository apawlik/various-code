## This are bits of code based on Data Carpentry material https://datacarpentry.org/R-ecology-lesson/04-visualization-ggplot2.html

# Step 1. Download the data:

#download.file(url = "https://ndownloader.figshare.com/files/2292169",
#              destfile = "data-raw/portal_data_joined.csv")

#Step 2. Load the library

library(tidyverse)

# Step 3. The basic syntax of ggplot
# ggplot( data = <DATA>, mapping = aes(<MAPPINGS>) ) +  <GEOM_FUNCTION>() 


surveys_complete <- read.csv("data-raw/portal_data_joined.csv")

ggplot( data=surveys_complete, mapping = aes(x=weight, y=hindfoot_length ) ) + geom_point()

survey_h_w_plot <- ggplot( data=surveys_complete, mapping = aes(x=weight, y=hindfoot_length ) )

survey_h_w_plot + geom_point(alpha=0.2, color="blue")

# Representing each species with different color
survey_h_w_plot + geom_point(alpha = 0.2, aes(color = species_id) )

# Let's compare the weights distribution across species
survey_species_w_plot <- ggplot( data=surveys_complete, mapping = aes(x= species_id, y=weight))
survey_species_w_plot + geom_boxplot(alpha=0.1) + geom_jitter(alpha=0.3, color="tomato")

#Time series data - visualisation

yearly_counts <- surveys_complete %>% count(year, taxa)
surveys_time_counts <- ggplot( data=yearly_counts, mapping = aes(x=year, y=n, color=taxa))
surveys_time_counts + geom_line()


yearly_counts_genus <- surveys_complete %>% count(year, genus)
surveys_time_genus <- ggplot( data=yearly_counts_genus, mapping= aes(x=year, y=n, color=genus))
surveys_time_genus + geom_line()


#Splitting one big graph to smaller graphs using faceting
surveys_time_genus + geom_line() + facet_wrap( facets = vars(genus))

#Time series: show how many M vs F were observed for each genus
yearly_counts_sex <- surveys_complete %>% count(year,genus, sex)
surveys_time_genus_sex <- ggplot( data=yearly_counts_sex, mapping= aes(x=year, y=n, color=sex))

surveys_time_genus_sex + 
   geom_line() + 
   facet_wrap(facets = vars(genus)) +
   labs(title = "Observed sex of animals (by genus)", x="Year of observation", y="Number of animals") +
   theme_light() +
   theme(axis.text.x = element_text(angle=90, size=9)  )





