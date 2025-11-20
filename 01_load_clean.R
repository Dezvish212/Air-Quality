library(tidyverse)
library(lubridate)
library(janitor)

data <- read_csv("data/AURN_2015_2023 Sample.csv")
data <- data %>% clean_names()
data <- data %>% mutate(date = ymd_hms(date),
                        year=year(date),
                        month=month(date,label=TRUE),
                        day=date(date))
data <- data %>% select(date,year,month,no2,pm10,pm25,everything())
saveRDS(data,"data/cleaned_data.rds")
