require(tidyr)
require(dplyr)
require(ggplot2)

setwd("~/DataVisualization/DV_RProject3/01 Data")

file_path <- "Salaries__OUS__Oregon_State_University__FY_2014.csv"

Oregon <- read.csv(file_path, stringsAsFactors = FALSE)

#str(Oregon) # Uncomment this and  run just the lines to here to get column types to use for getting the list of measures.

Oregon_measures <- c("ANNUALSALARY")

dimensions <- setdiff(names(Oregon), Oregon_measures)
if( length(Oregon_measures) > 1 || ! is.na(dimensions)) {
  for(d in dimensions) {
    # Get rid of " and ' in dimensions.
    Oregon[d] <- data.frame(lapply(Oregon[d], gsub, pattern="[\"']",replacement= ""))
    # Change & to and in dimensions.
    Oregon[d] <- data.frame(lapply(Oregon[d], gsub, pattern="&",replacement= " and "))
    # Change : to ; in dimensions.
    Oregon[d] <- data.frame(lapply(Oregon[d], gsub, pattern=":",replacement= ";"))
  }
}

library(lubridate)

# The following is an example of dealing with special cases like making state abbreviations be all upper case.
# df["State"] <- data.frame(lapply(df["State"], toupper))

# Get rid of all characters in measures except for numbers, the - sign, and period.dimensions
if( length(Oregon_measures) > 1 || ! is.na(Oregon_measures)) {
  for(m in Oregon_measures) {
    Oregon[m] <- data.frame(lapply(Oregon[m], gsub, pattern="[^--.0-9]",replacement= ""))
  }
}

write.csv(Oregon, paste(gsub(".csv", "", file_path), ".reformatted.csv", sep=""), row.names=FALSE, na = "")

tableName <- gsub(" +", "_", gsub("[^A-z, 0-9, ]", "", gsub(".csv", "", file_path)))
sql <- paste("CREATE TABLE", tableName, "(\n-- Change table_name to the table name you want.\n")
if( length(Oregon_measures) > 1 || ! is.na(dimensions)) {
  for(d in dimensions) {
    sql <- paste(sql, paste(d, "varchar2(4000),\n"))
  }
}
if( length(Oregon_measures) > 1 || ! is.na(Oregon_measures)) {
  for(m in Oregon_measures) {
    if(m != tail(Oregon_measures, n=1)) sql <- paste(sql, paste(m, "number(38,4),\n"))
    else sql <- paste(sql, paste(m, "number(38,4)\n"))
  }
}
sql <- paste(sql, ");")
cat(sql)


file_path2 <- "Salaries__OUS__Portland_State_University__FY_2014.csv"

Portland <- read.csv(file_path2, stringsAsFactors = FALSE)

#str(Portland) # Uncomment this and  run just the lines to here to get column types to use for getting the list of measures.

Portland_measures <- c("ANNUALSALARY")

dimensions <- setdiff(names(Portland), Portland_measures)
if( length(Portland_measures) > 1 || ! is.na(dimensions)) {
  for(d in dimensions) {
    # Get rid of " and ' in dimensions.
    Portland[d] <- data.frame(lapply(Portland[d], gsub, pattern="[\"']",replacement= ""))
    # Change & to and in dimensions.
    Portland[d] <- data.frame(lapply(Portland[d], gsub, pattern="&",replacement= " and "))
    # Change : to ; in dimensions.
    Portland[d] <- data.frame(lapply(Portland[d], gsub, pattern=":",replacement= ";"))
  }
}

library(lubridate)

# The following is an example of dealing with special cases like making state abbreviations be all upper case.
# df["State"] <- data.frame(lapply(df["State"], toupper))

# Get rid of all characters in measures except for numbers, the - sign, and period.dimensions
if( length(Portland_measures) > 1 || ! is.na(Portland_measures)) {
  for(m in Portland_measures) {
    Portland[m] <- data.frame(lapply(Portland[m], gsub, pattern="[^--.0-9]",replacement= ""))
  }
}

write.csv(Portland, paste(gsub(".csv", "", file_path2), ".reformatted.csv", sep=""), row.names=FALSE, na = "")

tableName <- gsub(" +", "_", gsub("[^A-z, 0-9, ]", "", gsub(".csv", "", file_path2)))
sql <- paste("CREATE TABLE", tableName, "(\n-- Change table_name to the table name you want.\n")
if( length(Portland_measures) > 1 || ! is.na(dimensions)) {
  for(d in dimensions) {
    sql <- paste(sql, paste(d, "varchar2(4000),\n"))
  }
}
if( length(Portland_measures) > 1 || ! is.na(Portland_measures)) {
  for(m in Portland_measures) {
    if(m != tail(Portland_measures, n=1)) sql <- paste(sql, paste(m, "number(38,4),\n"))
    else sql <- paste(sql, paste(m, "number(38,4)\n"))
  }
}
sql <- paste(sql, ");")
cat(sql)
