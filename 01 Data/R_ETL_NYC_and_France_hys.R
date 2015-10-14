require(tidyr)
require(dplyr)
require(ggplot2)

setwd("~/DataVisualization/DV_RProject3/01 Data")

file_path_France<- "CausesOfDeath_France_2001-2008.csv"

df_France <- read.csv(file_pathFrance, stringsAsFactors = FALSE)

#str(dfFrance) # Uncomment this and  run just the lines to here to get column types to use for getting the list of measures.

measures_France <- c("YEAR", "Value")

dimensions <- setdiff(names(df_France), measures_France)
if( length(measures_France) > 1 || ! is.na(dimensions)) {
  for(d in dimensions) {
    # Get rid of " and ' in dimensions.
    df_France[d] <- data.frame(lapply(df_France[d], gsub, pattern="[\"']",replacement= ""))
    # Change & to and in dimensions.
    df_France[d] <- data.frame(lapply(df_France[d], gsub, pattern="&",replacement= " and "))
    # Change : to ; in dimensions.
    df_France[d] <- data.frame(lapply(df_France[d], gsub, pattern=":",replacement= ";"))
  }
}

library(lubridate)

# The following is an example of dealing with special cases like making state abbreviations be all upper case.
# df["State"] <- data.frame(lapply(df["State"], toupper))

# Get rid of all characters in measures except for numbers, the - sign, and period.dimensions
if( length(measures_France) > 1 || ! is.na(measures_France)) {
  for(m in France_measures) {
    df_France[m] <- data.frame(lapply(df_France[m], gsub, pattern="[^--.0-9]",replacement= ""))
  }
}

write.csv(df_France, paste(gsub(".csv", "", file_path_France), ".reformatted.csv", sep=""), row.names=FALSE, na = "")

France_tableName <- gsub(" +", "_", gsub("[^A-z, 0-9, ]", "", gsub(".csv", "", file_pathFrance)))
sql <- paste("CREATE TABLE", FrancetableName, "(\n-- Change table_name to the table name you want.\n")
if( length(measures_France) > 1 || ! is.na(dimensions)) {
  for(d in dimensions) {
    sql <- paste(sql, paste(d, "varchar2(4000),\n"))
  }
}
if( length(measures_France) > 1 || ! is.na(measures_France)) {
  for(m in measures_France) {
    if(m != tail(measures_France, n=1)) sql <- paste(sql, paste(m, "number(38,4),\n"))
    else sql <- paste(sql, paste(m, "number(38,4)\n"))
  }
}
sql <- paste(sql, ");")
cat(sql)

############################

file_path_NYC <- "New_York_City_Leading_Causes_of_Death.csv"

df_NYC <- read.csv(file_path_NYC, stringsAsFactors = FALSE)
measures_NYC <- c("YEAR", "Count", "Percent")

#str(df_NYC) # Uncomment this and  run just the lines to here to get column types to use for getting the list of measures.

measures_NYC <- c("YEAR", "Count", "Percent")

dimensions <- setdiff(names(df_NYC), measures_NYC)
if( length(measures_NYC) > 1 || ! is.na(dimensions)) {
  for(d in dimensions) {
    # Get rid of " and ' in dimensions.
    df_NYC[d] <- data.frame(lapply(df_NYC[d], gsub, pattern="[\"']",replacement= ""))
    # Change & to and in dimensions.
    df_NYC[d] <- data.frame(lapply(df_NYC[d], gsub, pattern="&",replacement= " and "))
    # Change : to ; in dimensions.
    df_NYC[d] <- data.frame(lapply(df_NYC[d], gsub, pattern=":",replacement= ";"))
  }
}

library(lubridate)

# The following is an example of dealing with special cases like making state abbreviations be all upper case.
# df["State"] <- data.frame(lapply(df["State"], toupper))

# Get rid of all characters in measures except for numbers, the - sign, and period.dimensions
if( length(measures_NYC) > 1 || ! is.na(measures_NYC)) {
  for(m in measures_NYC) {
    df_NYC[m] <- data.frame(lapply(df_NYC[m], gsub, pattern="[^--.0-9]",replacement= ""))
  }
}

write.csv(df_France, paste(gsub(".csv", "", file_path_France), ".reformatted.csv", sep=""), row.names=FALSE, na = "")

tableName <- gsub(" +", "_", gsub("[^A-z, 0-9, ]", "", gsub(".csv", "", file_pathFrance)))
sql <- paste("CREATE TABLE", tableName, "(\n-- Change table_name to the table name you want.\n")
if( length(measures_France) > 1 || ! is.na(dimensions)) {
  for(d in dimensions) {
    sql <- paste(sql, paste(d, "varchar2(4000),\n"))
  }
}
if( length(measures_France) > 1 || ! is.na(measures_France)) {
  for(m in measures_France) {
    if(m != tail(measures_France, n=1)) sql <- paste(sql, paste(m, "number(38,4),\n"))
    else sql <- paste(sql, paste(m, "number(38,4)\n"))
  }
}
sql <- paste(sql, ");")
cat(sql)
