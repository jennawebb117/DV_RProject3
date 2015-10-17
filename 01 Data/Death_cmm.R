require("jsonlite")
require("RCurl")
require("dplyr")
require("ggplot2")

df_FranceDeaths <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from FranceDeaths"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_cmm5627', PASS='orcl_cmm5627', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))

df_NewYorkDeaths <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from NewYorkDeaths"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_cmm5627', PASS='orcl_cmm5627', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))

df_bind <- dplyr::left_join(df_NewYorkDeaths,df_FranceDeaths,by="YEAR") 
df_bind <- dplyr::distinct(df_bind)
df_bind <- dplyr::rename(df_bind, NY_SEX = SEX.x)
df_bind <- dplyr::rename(df_bind, FRANCE_SEX = SEX.y)

df_bind %>% select(YEAR, CAUSEOFDEATH, COUNT, FRANCE_SEX, NY_SEX) %>% filter(CAUSEOFDEATH == "ACCIDENTS EXCEPT DRUG POISONING")%>% filter(FRANCE_SEX != "NA" & NY_SEX != "NA") %>% ggplot(aes(x = NY_SEX, y = FRANCE_SEX, color = COUNT)) + ggtitle("Accidents as Cause Death in France and New York 2007-2011 ") + geom_point(position = "jitter")
