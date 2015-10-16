require(tidyr)
require(dplyr)
require(ggplot2)
require(jsonlite)
require(RCurl)
library(gridExtra)

g1 <- df_full %>% select(YEAR, SEX.x, SEX.y, CAUSE, CAUSEOFDEATH, COUNT, VALUE) %>% filter(CAUSEOFDEATH == "INTENTIONAL SELF-HARM (SUICIDE)", CAUSE == "Intentional self-harm") %>% ggplot(aes(x = YEAR, y = VALUE, color = CAUSE)) + geom_point(position = "jitter") + facet_wrap(~SEX.x) + theme(axis.text.x=element_text(angle=70, size = 10, vjust=0.5)) + ggtitle("France Suicides") 

g2 <- df_full %>% select(YEAR, SEX.x, SEX.y, CAUSE, CAUSEOFDEATH, COUNT, VALUE) %>% filter(CAUSEOFDEATH == "INTENTIONAL SELF-HARM (SUICIDE)", CAUSE == "Intentional self-harm") %>% ggplot(aes(x = YEAR, y = COUNT, color = CAUSEOFDEATH)) + geom_point(position = "jitter") + facet_wrap(~SEX.y) + theme(axis.text.x=element_text(angle=70, size = 10, vjust=0.5)) + ggtitle("New York Suicides") 

g1
g2
