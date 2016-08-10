
##--------------  Data manipulation: Read in the raw data ---------------##
#Clear working space
rm(list = ls())

#Source some functions and load packages
source("./R/packages.R")

# Read data
data <- read.xls("./data/ELE_1596_sm_appendixS1.xls", blank.lines.skip = TRUE, stringsAsFactors = FALSE)

# Weird data read, added extra columns and and we want to clean up this data to make it look pretty.
str(data)

# Check whether there are NA's where these are and if they are anything to worry about
data[!complete.cases(data),]  # Looks ok as authors got the core data from other authors.

# Remove last four NA columns
data <- data[ , 1:(ncol(data)-4)]

# We definitely don't need the Article title or authors for our analysis so let's ditch that
data <- data[ , ! colnames(data) %in% c("Article.title")]

# Also, let's get rid of this long list of authors and just focus on paper numbers. Need to replace all unique author lists with a numeric variable
mergedat <- data.frame(Authors = unique(data$Authors), paper = 1:length(unique(data$Authors)))
data <- merge(data, mergedat, "Authors")
data <- data[ , ! colnames(data) %in% c("Authors")]

# Ok. Getting close. Looks like there was a lone space at the end of teh file contributing to NA. Let's just ditch that one and then arrange on paper
data <- plyr::arrange(data[ ! data$pap == 47, ], paper)

# Reorder columns so paper is first
names <- colnames(data)[!colnames(data) %in% c("paper", "detailed.treatment")]
data <- data[, c("paper", names)]

# One last change. Authors took composite native species for one study so lets just shorten this 
data$native.species <- ifelse(data$native.species == "Podolepis gracilis, Podotheca chysantha, Podotheca gnapphaliodes, Rhodanthe manglesii, waitzia suaveolens", "multi.spp", data$native.species)

# Looks like the authors have some crazy digits probably from calculations with excel. Lets round everything to three digits. 
data <- round_df(data, 3)

# Export final data
write.csv(data, file = "./output/data/plast_metadata.csv", row.names = FALSE)

