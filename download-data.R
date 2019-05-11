url <- "https://en.wikipedia.org/wiki/Solar_power_by_country"
h <- read_html(url)
table <- h %>% html_nodes("table")
table_1 <- table[[3]]
table_raw <- table_1 %>% html_table(fill=TRUE)

#Subsetting - Remove Row 55
table_clean_1 <- table_raw[-55,]

#Change Column Name
column_names <- c("Country","2015 Added","2015 Total","2016 Added","2016 Total","2017 Added","2017 Total","2018 Added","2018 Total","Share of total consumption")
table_clean_2 <- table_clean_1 %>% setNames(column_names)

#Subsetting - Remove Row 1
table_clean_3 <- table_clean_2[-1,-3,-54]

#Tidy Table
table_clean_4 <- table_clean_3 %>% select(1:9) %>% gather(key,value,-1)
table_clean_5 <- table_clean_4 %>% separate(into= c("Year","Type"),2)

#Remove comma and parse number
str_count(table_clean_5$value,pattern = ",")
str_replace(table_clean_5$value,pattern = ",", replacement = "")
table_clean_6 <- table_clean_5 %>% mutate_at(4,parse_number) %>% mutate_at(2:3,parse_factor)
str(table_clean_6)
