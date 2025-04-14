
################################################################################
# Direct watershed and catchment data download from EPA's StreamCat Dataset. 
# 
# Lily Conrad
# last update: 2/5/2025
# 
# Data citation: 
# Weber, Marc H, Hill, Ryan A., Brookes, Allen F. 2024, StreamCatTools: Tools to 
# work with the StreamCat API within R and access the full suite of StreamCat and 
# LakeCat metrics, https://usepa.github.io/StreamCatTools
################################################################################


# To get started, provide the user inputs below following the outlined format.
# Please review the instructions and examples carefully, the format matters. 


### User inputs ----------------------------------------------------------------

# Identify your area of interest. See this link for descriptions of the options:
# https://www.epa.gov/national-aquatic-resource-surveys/streamcat-dataset-readme#geospatial
# If you want to enter multiple, separate them by commas, but include all entries
# in the same pair of quotation marks and with no spaces between them.  
aoi <- "catchment"
 
# Run this line of code. 
parameter_codes <- sc_get_params(param='name') %>% as.data.frame()

# You should see an item appear with the name "parameter_codes" under your Global
# Environment (top right window). Click on it to open it in a new tab. Then 
# Check go to this website: https://www.epa.gov/national-aquatic-resource-surveys/streamcat-metrics-and-definitions). 
# Check the information on the website to help you identify which parameters you
# would like to download then enter your parameters of interest below. Make 
# sure that the words you enter match up with the valid codes from the parameter_code
# table you created in R. 
# If you want to enter multiple, separate them by commas, but include all entries
# in the same pair of quotation marks and with no spaces between them.  
# Enter your parameters of interest. 
metric <- "rddens,septic,WettedWidth,BankfullWidth,precip9120,runoff,pcturbhi2019"

# If you know which county/counties your watershed is located in, enter it below.
# Enter the FIPS code, not the name (https://www.weather.gov/media/pimar/FIPS/id_cnty.pdf). 
# If you want to enter multiple, separate them by commas, but include all entries
# in the same pair of quotation marks and with no spaces between them. 
county <- "16059,16037"

# Enter your username (the name at the beginning of your computer's file explorer
# path) in quotations.
my_name <- "jdoe"


# Now that you've entered the values above, click on "Source" and watch
# your console for errors. If the script ran successfully, there will be a new
# Excel file in your Downloads folder. 


################################################################################
#                                 START
################################################################################

### Load packages and data -----------------------------------------------------

my_packages <- c("dplyr", "openxlsx", "remotes")
install.packages(my_packages, repos = "http://cran.rstudio.com")

library(dplyr)
library(openxlsx)
library(remotes)
install_github("USEPA/StreamCatTools", build_vignettes=FALSE) # most recent approved version
library(StreamCatTools)


### Retrieve data --------------------------------------------------------------

# Data query.            
sc.dat <- sc_get_data(aoi = aoi,
                      metric = metric,
                      county = county,
                      state = 'ID')


# Save the data to excel. This will save the file in your downloads folder
# Adjust the file path if you'd like it to save somewhere else.
write.xlsx(sc.dat, paste0("C:/Users/",my_name,"/Downloads/",Sys.Date(),"StreamCat_download.xlsx"))


################################################################################
#                                 END
################################################################################
