library(tidyverse)
library(lubridate)

data <- readRDS("data/cleaned_data.rds")
pm <- data %>% filter(year>=2015) %>% select(date,year,pm25,pm10) %>% drop_na()
pm_yearly <- pm %>% group_by(year) %>% summarise(pm25=mean(pm25),pm10=mean(pm10))

p_pm25 <- ggplot(pm_yearly,aes(year,pm25))+geom_line()+geom_point()
ggsave("plots/PM25_yearly_mean.png",p_pm25,width=7,height=4)

p_pm10 <- ggplot(pm_yearly,aes(year,pm10))+geom_line()+geom_point()
ggsave("plots/PM10_yearly_mean.png",p_pm10,width=7,height=4)

print(pm_yearly)
