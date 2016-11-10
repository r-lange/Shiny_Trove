#setting up queires and downloading data from trove
# basic query
# http://api.trove.nla.gov.au/result?key=<INSERT KEY>&zone=<ZONE NAME>&q=<YOUR SEARCH TERMS>

library(RJSONIO)
library(dplyr)

url_base="http://api.trove.nla.gov.au/result?key="
api_key="u0pi59qa33f2f3e2"
zone="&zone="
query="&q="
type="&encoding=json"

zone_name="newspaper"
question="john%20curtin%20kip"

url_query=paste0(url_base,api_key,zone,zone_name,query,question,type)
url_query2=paste0(url_base,api_key,zone,zone_name,query,question)

download.file(url_query2,destfile = "curtin_kip.xml")

# trying ot download the json data
json_file=RJSONIO::fromJSON(url_query)

json_file <- lapply(json_file, function(x) {
  x[sapply(x, is.null)] <- NA
  unlist(x)
})

dat=do.call("rbind", json_file)

dplyr::rbind_all(fromJSON(url_query))

# working with the xml data
library(XML)
library(plyr)
test=xmlToList(url_query2)

testdf=ldply(xmlToList(url_query2), function(x) { data.frame(x) } )

