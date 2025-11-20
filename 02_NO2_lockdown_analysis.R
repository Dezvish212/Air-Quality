library(tidyverse)
library(lubridate)

data <- readRDS("data/cleaned_data.rds")
no2_data <- data %>% filter(year %in% c(2019,2020,2021)) %>% drop_na(no2)
lockdown_start <- ymd("2020-03-23")
no2_periods <- no2_data %>% mutate(period=if_else(date<lockdown_start,"Before","After"))

p1 <- no2_data %>% 
 group_by(date=floor_date(date,"week")) %>%
 summarise(no2=mean(no2,na.rm=TRUE)) %>%
 ggplot(aes(date,no2,color=factor(year)))+geom_line()+geom_vline(xintercept=as.numeric(lockdown_start))
ggsave("plots/NO2_time_series_2019_2021.png",p1,width=9,height=5)

p2 <- ggplot(no2_periods,aes(period,no2,fill=period))+geom_boxplot()
ggsave("plots/NO2_before_after_lockdown_boxplot.png",p2,width=6,height=4)

test_result <- wilcox.test(no2_periods$no2[no2_periods$period=="Before"],
                           no2_periods$no2[no2_periods$period=="After"])
print(test_result)
