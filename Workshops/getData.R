# load packages

library(tidyverse)
library(readr) #can get data directly from url

# load api specific packages

library(rsdmx) #for XML based data
library(plumber) #for rest api or open api

# find out about all SDMX service providers
providers <- getSDMXServiceProviders()
as.data.frame(providers)



#### parameters in a URL:
#### stats.oecd.org/restsdmx/sdmx.ashx/GetData/<dataset identifier>
#### /<filter expression>/<agency name>[?<additional parameters>]

#### dataset identifier = the ID of the dataset you want to querie
#### filter expression = desired dimension values.
    #### dimensions separated by a dot
    #### values in dimensions separated by +
    #### use all keyword to get all available dimensions
#### agency name = agency name of the artefact
#### optional parameter = format of the result



# download OECD data using their SDMX interfaced API ----
(url<-"http://stats.oecd.org/restsdmx/sdmx.ashx/GetData/EAG_NEAC/AUS.L0T2+L0+L1_T_SC3T4+L2_T_SC2+L2_T_SC3T4+L3_T_SC2+L3T4+L3+L4+L5T8+L5+L6+L7+L8.T+F+M.Y25T64.T.VALUE+SE.NEAC_SHARE_EA/all?startTime=9999&endTime=9999")

eag.neac <- readSDMX(url)

url

eag.neac_dsd <- readSDMX(#we are going to use the same parameters as we filtered on to get the direct url - make sure you can see how it all came out
  providerId ="OECD", 
  resource ="data", 
  flowRef ="EAG_NEAC",
  key ="/AUS.L0T2+L0+L1_T_SC3T4+L2_T_SC2+L2_T_SC3T4+L3_T_SC2+L3T4+L3+L4+L5T8+L5+L6+L7+L8.T+F+M.Y25T64.T.VALUE+SE.NEAC_SHARE_EA/all", 
  key.mode ="SDMX",
  dsd =TRUE) #this is where we say we want the data definition

(employment <- as.data.frame(eag.neac_dsd))




# httr
library(httr)
library(jsonlite)
