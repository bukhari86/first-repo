#Filter data frame

my_data <- table_clean_6 %>% filter(value != is.na(value), Type == "Total")
str(my_data)

my_plot <- my_data %>% group_by(Country) %>% ggplot(aes(Year,value,label=Country)) +
  geom_point(aes(color=Country)) +
  ylab("Solar PV Capacity, MW") +
  scale_y_log10() +
  theme_economist()

G7 <- c("United States", "United Kingdom", "Canada","France","Germany","Italy","Japan")
my_plot2 <- my_data %>% filter(Country %in% G7,Year == "2018") %>% ggplot(aes(x=Country,fill=Country)) +
  geom_bar(aes(y=value),stat = "identity") +
  
  ylab("Solar PV Capacity, MW") +
  xlab("") +
  ggtitle("Solar PV Capacity (MW) in G7 in 2018") +
  
  theme_economist()

save(my_plot,file = "my_plot.rda")

