Taiwan Voter Demography  
=======================  

Goals :   
1. Transform demography data from MOI Taiwan into g0v format.  
2. Transofrm demography data from MOI Taiwan into tidy data set.  
   (Tidy data http://ramnathv.github.io/pycon2014-r/explore/tidy.html)  

Usage :  
1. Go to http://data.moi.gov.tw/MoiOD/Data/DataDetail.aspx?oid=F4478CE5-7A72-4B14-B91A-F4701758328F  
   and download 村里戶數人口數單一年齡人口數. The suffix indicate the updating date of data set.  
   e.g. -10309 = 103 year (2014), September.  
2. Unzip data set into a folder.  
3. Put tidyDemography.R in the same folder.  
4. Start R or R.Studio.  
5. Use source("tidyDemography.R", encoding="UTF-8") to load script.  
6. Excute processFileList(dataFileList) to batch process all dataset in the folder.  

Todo :   
1. codebook.md  
