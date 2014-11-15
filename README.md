Taiwan Voter Demography  
=======================  

Goals :   
1. Transform demography data from MOI Taiwan into g0v format.  
2. Transofrm demography data from MOI Taiwan into tidy data set.  
   (Tidy data http://ramnathv.github.io/pycon2014-r/explore/tidy.html)  

Requirement :   
1. R, R.Studio or other compatible R IDE.  
2. R package : tidyr, dplyr  

Usage :  
1. Go to http://data.moi.gov.tw/MoiOD/Data/DataDetail.aspx?oid=F4478CE5-7A72-4B14-B91A-F4701758328F  
   and download 村里戶數人口數單一年齡人口數. The suffix indicate the updating date of data set.  
   e.g. -10309 = 103 year (2014), September.  
2. Unzip data set into a folder.  
3. Put tidyDemography.R in the same folder.  
4. Start R or R.Studio.  
5. To load script: source("tidyDemography.R", encoding="UTF-8")  
6. To generate demography in g0v format : g0vDemo().  
   This script will automatically detect csv files in the same folder and processes all of them.  
   Please make sure there are only legitimite csv files in the same folder.  
7. To generate tidy demography: regionDemo <- tidyDemo(regionDemoFileName).  
   This function will return a data set for exploratory data analysis.  

Todo :   
1. codebook.md  
2. 縣市輸出檔名確認  
