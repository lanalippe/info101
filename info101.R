library(ggplot2)
library(marinecs100b)


# Questionable organization choices ---------------------------------------

# P1 Call the function dir() at the console. This lists the files in your
# project's directory. Do you see woa.csv in the list? (If you don't, move it to
# the right place before proceeding.)


# P2 Critique the organization of woa.csv according to the characteristics of
# tidy data.
# there are not a lot of names causing the data to be confusing


# Importing data ----------------------------------------------------------

# P3 P3 Call read.csv() on woa.csv. What error message do you get? What do you
# think that means?
read.csv("woa.csv")
#i got the error that woa.csv was not found
# P4 Re-write the call to read.csv() to avoid the error in P3.
woa_wide <- read.csv("woa.csv", skip = 1)
View(woa_wide)

# Fix the column names ----------------------------------------------------

# P5 Fill in the blanks below to create a vector of the depth values.

depths <- c(
  seq(0, 100, by = 5),
  seq(125, 500, by = 25),
  seq(550, 2000, by = 50),
  seq(2100, 5500, by = 100)
)



# P6 Create a vector called woa_colnames with clean names for all 104 columns.
# Make them the column names of your WOA data frame.

woa_colnames <- c("latitude", "longitude", paste0("depth_" , depths))
colnames(woa_wide) <- woa_colnames
paste0(woa_wide)



# Analyzing wide-format data ----------------------------------------------

# P7 What is the mean water temperature globally in the twilight zone (200-1000m
# depth)?

twilight_temps <- woa_wide [ ,27:49]
temp <- woa_wide [ ,27:49]

twilight_sum <- sum(twilight_temps, na.rm = TRUE)

number_measurments <- (sum(!is.na(woa_wide [ ,27:49])))

sum(twilight_temps, na.rm = TRUE)/number_measurments
#6.573227

# Analyzing long-format data ----------------------------------------------

# P8 Using woa_long, find the mean water temperature globally in the twilight zone.

install.packages("remotes")
remotes::install_github("MarineCS-100B/marinecs100b")

View(woa_long)
twilight_temps <- woa_long[woa_long$depth_m >= 200 & woa_long$depth_m <= 1000, 4]
mean(twilight_temps)
#6.573227


# P9 Compare and contrast your solutions to P8 and P9.
# They both got the same answer but P8 was much simpler than P7 because you could
#directly find the mean instead of building a complex function to find the same thing

# P10 Create a variable called mariana_temps. Filter woa_long to the rows in the
# location nearest to the coordinates listed in the in-class instructions.
mariana_lat <- woa_long[woa_long$latitude == 11.5, ]
mariana_long <- woa_long[woa_long$longitude == 142.5, ]
mariana_lat
mariana_long
mariana_temps <- woa_long[woa_long$latitude == 11.5 & woa_long$longitude == 142.5, ]
mariana_temps

# P11 Interpret your temperature-depth profile. What's the temperature at the surface? How about in the deepest parts? Over what depth range does temperature change the most?
#at the surface, the temperature is 29 degrees C. At the deepest point the temp
#is around 2 degrees C. The temp changes the most between 2000M and 0M.
# ggplot is a tool for making figures, you'll learn its details in COMM101

ggplot(mariana_temps, aes(temp_c, depth_m)) +
  geom_path() +
  scale_y_reverse()
