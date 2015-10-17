require(tidyr)
require(dplyr)
require(ggplot2)
require(jsonlite)
require(RCurl)

Plot <- df_bind %>% select(YEAR, CAUSEOFDEATH, COUNT, FRANCE_SEX, NY_SEX) %>% filter(CAUSEOFDEATH == "ACCIDENTS EXCEPT DRUG POISONING")%>% filter(FRANCE_SEX != "NA" & NY_SEX != "NA") %>% ggplot(aes(x = NY_SEX, y = FRANCE_SEX, color = COUNT)) + ggtitle("Accidents as Cause Death in France and New York 2007-2011 ") + geom_point(position = "jitter")

Plot
