require(tidyr)
require(dplyr)
require(ggplot2)

setwd("C:/Users/jenna_000/Jennas_Stuff/UT/DataVisualization/DV_RProject3/01 Data")

file_path <- "CausesOfDeath_France_2001-2008.csv"

France <- read.csv(file_path, stringsAsFactors = FALSE)

#str(France) # Uncomment this and  run just the lines to here to get column types to use for getting the list of measures.

France_measures <- c("YEAR", "Value")

dimensions <- setdiff(names(France), France_measures)
if( length(France_measures) > 1 || ! is.na(dimensions)) {
  for(d in dimensions) {
    # Get rid of " and ' in dimensions.
    France[d] <- data.frame(lapply(France[d], gsub, pattern="[\"']",replacement= ""))
    # Change & to and in dimensions.
    France[d] <- data.frame(lapply(France[d], gsub, pattern="&",replacement= " and "))
    # Change : to ; in dimensions.
    France[d] <- data.frame(lapply(France[d], gsub, pattern=":",replacement= ";"))
  }
}

library(lubridate)

# The following is an example of dealing with special cases like making state abbreviations be all upper case.
# df["State"] <- data.frame(lapply(df["State"], toupper))

# Get rid of all characters in measures except for numbers, the - sign, and period.dimensions
if( length(France_measures) > 1 || ! is.na(France_measures)) {
  for(m in France_measures) {
    France[m] <- data.frame(lapply(France[m], gsub, pattern="[^--.0-9]",replacement= ""))
  }
}

write.csv(France, paste(gsub(".csv", "", file_path), ".reformatted.csv", sep=""), row.names=FALSE, na = "")

tableName <- gsub(" +", "_", gsub("[^A-z, 0-9, ]", "", gsub(".csv", "", file_path)))
sql <- paste("CREATE TABLE", tableName, "(\n-- Change table_name to the table name you want.\n")
if( length(France_measures) > 1 || ! is.na(dimensions)) {
  for(d in dimensions) {
    sql <- paste(sql, paste(d, "varchar2(4000),\n"))
  }
}
if( length(France_measures) > 1 || ! is.na(France_measures)) {
  for(m in France_measures) {
    if(m != tail(France_measures, n=1)) sql <- paste(sql, paste(m, "number(38,4),\n"))
    else sql <- paste(sql, paste(m, "number(38,4)\n"))
  }
}
sql <- paste(sql, ");")
cat(sql)

file_path2 <- "New_York_City_Leading_Causes_of_Death.csv"

NewYork <- read.csv(file_path2, stringsAsFactors = FALSE)

#str(NewYork)

NewYork_measures <- c("YEAR", "COUNT", "PERCENT")

NY_dimensions <- setdiff(names(NewYork), NewYork_measures)
if( length(NewYork_measures) > 1 || ! is.na(NY_dimensions)) {
  for(d in NY_dimensions) {
    # Get rid of " and ' in dimensions.
    NewYork[d] <- data.frame(lapply(NewYork[d], gsub, pattern="[\"']",replacement= ""))
    # Change & to and in dimensions.
    NewYork[d] <- data.frame(lapply(NewYork[d], gsub, pattern="&",replacement= " and "))
    # Change : to ; in dimensions.
    NewYork[d] <- data.frame(lapply(NewYork[d], gsub, pattern=":",replacement= ";"))
  }
}

# Get rid of all characters in measures except for numbers, the - sign, and period.dimensions
if( length(NewYork_measures) > 1 || ! is.na(NewYork_measures)) {
  for(m in NewYork_measures) {
    NewYork[m] <- data.frame(lapply(NewYork[m], gsub, pattern="[^--.0-9]",replacement= ""))
  }
}

write.csv(NewYork, paste(gsub(".csv", "", file_path2), ".reformatted.csv", sep=""), row.names=FALSE, na = "")

tableName <- gsub(" +", "_", gsub("[^A-z, 0-9, ]", "", gsub(".csv", "", file_path2)))
sql <- paste("CREATE TABLE", tableName, "(\n-- Change table_name to the table name you want.\n")
if( length(NewYork_measures) > 1 || ! is.na(NY_dimensions)) {
  for(d in NY_dimensions) {
    sql <- paste(sql, paste(d, "varchar2(4000),\n"))
  }
}
if( length(NewYork_measures) > 1 || ! is.na(NewYork_measures)) {
  for(m in NewYork_measures) {
    if(m != tail(NewYork_measures, n=1)) sql <- paste(sql, paste(m, "number(38,4),\n"))
    else sql <- paste(sql, paste(m, "number(38,4)\n"))
  }
}
sql <- paste(sql, ");")
cat(sql)

