require(tidyr)
require(dplyr)
require(ggplot2)
require(jsonlite)
require(RCurl)
library(gridExtra)

g1 <- df_full %>% select(YEAR, SEX.x, SEX.y, CAUSE, CAUSEOFDEATH, COUNT, VALUE) %>% filter(CAUSEOFDEATH == "INTENTIONAL SELF-HARM (SUICIDE)", CAUSE == "Intentional self-harm") %>% ggplot(aes(x = YEAR, y = VALUE, color = SEX.x)) + geom_point(position = "jitter") + facet_wrap(~SEX.x) + ggtitle("France Suicides") 

g2 <- df_full %>% select(YEAR, SEX.x, SEX.y, CAUSE, CAUSEOFDEATH, COUNT, VALUE) %>% filter(CAUSEOFDEATH == "INTENTIONAL SELF-HARM (SUICIDE)", CAUSE == "Intentional self-harm") %>% ggplot(aes(x = YEAR, y = COUNT, color = SEX.y)) + geom_point(position = "jitter") + facet_wrap(~SEX.y) + ggtitle("New York Suicides") 

g1
g2
