# Some functions

# Function for installing a bunch of packages
install.pkg <- function(pkg){
	pkgNeed <- pkg[!pkg %in% installed.packages()[,"Package"]]
 if(length(pkgNeed) == 0){
 	sapply(pkg, library, character = TRUE)
 	}else {
 	install.packages(pkgNeed, dependencies = TRUE)
 	sapply(pkgNeed, library, character = TRUE)
	 }
}

# Function for quickly rounding a dataframe
round_df <- function(x, digits) {
    # round all numeric variables
    # x: data frame 
    # digits: number of digits to round
    numeric_columns <- sapply(x, class) == 'numeric'
    x[numeric_columns] <-  round(x[numeric_columns], digits)
    x
}

## Added some detail about the above function Sounds a dataframe.

