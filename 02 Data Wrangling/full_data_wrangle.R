require(tidyr)
require(dplyr)
require(ggplot2)
require(jsonlite)
require(RCurl)

df_full %>% select(YEAR, SEX.x, SEX.y, CAUSE, CAUSEOFDEATH, COUNT, VALUE) %>% filter(CAUSEOFDEATH == "INTENTIONAL SELF-HARM (SUICIDE)", CAUSE == "Intentional self-harm") %>% ggplot(aes(x = YEAR, y = VALUE, color = SEX.x)) + geom_point(position = "jitter") + facet_wrap(~SEX.x)  + ggtitle("Title") 

