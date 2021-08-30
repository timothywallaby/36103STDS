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

res = GET("https://zapier.com/learn/apis/chapter-2-protocols/")
  #output returns a list

res
  #use the content-type to see what you can get out of this API
  #from here you can extract data in the html file

res2 = GET("http://api.open-notify.org/iss-pass.json",
    query = list(lat = 40.7, lon = -74))
  #check documentation of the API you are working with to see if you need any required query parameters

data = fromJSON(rawToChar(res2$content))

data$response

#GET retrieve
#POST make a resource with parameters
#PUT change your order
#DELETE delete a resource

# token FPuXWiBep3nfBEIVGyK9twNidbuv
# https://developers.amadeus.com/self-service/category/air/api-doc/flight-delay-prediction/api-reference

# base url test.api.amadeus.com/v1
# /airport/predictions/on-time

token = "FPuXWiBep3nfBEIVGyK9twNidbuv"
urlpath = "https://test.api.amadeus.com/v1/airport/predictions/on-time"
delays <-  GET(
          url = urlpath,
          query = list(airportCode = "JFK", date="2020-12-01"),
          add_headers(`Authorization` = sprintf("Token %s", token))
          )
delays

delaydata = fromJSON(rawToChar(delays$content))

delaydata$response

Airlines <- GET( url = 'https://api.aviationstack.com/v1/airlines',
                 'access_key' = 'fcd5517a6124bc5f203f3cbd7554a471')

Airlines

icao <- GET(
  https://applications.icao.int/dataservices/api/safety-characteristics-list?api_key=8d00ef90-0982-11ec-9d72-8160549d64ab&airports=&states=USA&format=csv
