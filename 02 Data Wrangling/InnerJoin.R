# Change the USER and PASS below to be your UTEid
dfFrance <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from DeathsFrance"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_hys82', PASS='orcl_hys82', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))
View(dfFrance)

dfNYC <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from DeathsNYC"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_hys82', PASS='orcl_hys82', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))
View(dfNYC)

innerj <- dplyr::inner_join(dfFrance, dfNYC, by="YEAR")
View(innerj)

innerj %>% select(YEAR, ETHNICITY, SEX.x, SEX.y, CAUSE, CAUSEOFDEATH, COUNT, VALUE) %>% filter(CAUSEOFDEATH == "ASSAULT (HOMICIDE)", CAUSE == "Assault") %>% ggplot(aes(x = YEAR, y = VALUE, color = SEX.x)) + geom_point(position = "jitter") + theme(axis.text.x=element_text(angle=70, size = 10, vjust=0.5)) + ggtitle("France Homicide")

innerj %>% select(YEAR, ETHNICITY, SEX.x, SEX.y, CAUSE, CAUSEOFDEATH, COUNT, VALUE) %>% filter(CAUSEOFDEATH == "ASSAULT (HOMICIDE)", CAUSE == "Assault") %>% ggplot(aes(x = YEAR, y = COUNT, color = SEX.y)) + geom_point(position = "jitter") + theme(axis.text.x=element_text(angle=70, size = 10, vjust=0.5)) + ggtitle("NYC Homicide")

                                                        
                     
