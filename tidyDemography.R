library(tidyr)
library(dplyr)

tidyDemo <- function(file = NULL){
	raw <- readLines(file, encoding="UTF-8")
	raw2 <- read.csv(textConnection(paste0(raw, collapse="\n")),  header=FALSE, stringsAsFactors=FALSE)

	variableName <- raw2[1, 1:209]
	variableName[1,1] <- "統計年月"
	variableName[5] <- "總人口數"
	variableName[6] <- "總人口數男"
	variableName[7] <- "總人口數女"
	variableName <- sub("-", ".", variableName)

	names(raw2) <- variableName
	raw2 <- raw2[2:dim(raw2)[1], 1:dim(raw2)[2]-1]	
	raw2 <- raw2[(!is.na(raw2$統計年月)),]
	
	tidier <- raw2 %>% gather(
			sexage, 
			population, 
			-統計年月, 
			-區域別, 
			-村里, 
			-戶數, 
			-總人口數, 
			-總人口數男, 
			-總人口數女
		)

	tidyAll <- tidier %>% separate(sexage, into = c("年齡", "性別"), sep = "\\.") 		
	tidyAll$年齡 <- sub("歲", "", tidyAll$年齡)
	tidyAll$年齡 <- sub("以上", "", tidyAll$年齡)		
	tidyAll[,c(1,4,5,6,7,8,10)] <- as.numeric(unlist(tidyAll[,c(1,4,5,6,7,8,10)]))
	### tidyAll <- tidyAll[(!is.na(tidyAll$統計年月)),]
	tidyVoter <- tidyAll[(tidyAll$年齡 >= 20),]

	splitedChar <- ""
	if(grepl("縣", tidyAll$區域別[1])){
		splitedChar <- "縣"
	}else if(grepl("市", tidyAll$區域別[1])){
		splitedChar <- "市"
	}
	cityName <- unlist(strsplit(tidyAll$區域別[1], "市|縣", fixed = FALSE))[1]
	cityName <- paste(cityName, splitedChar, sep="")
	tidyVoterZone <- data.frame(
		統計年月=tidyAll$統計年月[1], 
		區域別=cityName, 
		性別=rep(c("男","女"), each=81), 
		年齡=rep(c(20:100), 2), 
		人口=0)	

	for(age in 20:100){
		ageSubSet <- tidyAll[(tidyAll$年齡 == age & tidyAll$性別 == "男"),]$population
		tidyVoterZone[(tidyVoterZone$年齡 == age & tidyVoterZone$性別 == "男"),]$人口 <- sum(ageSubSet)
		ageSubSet <- tidyAll[(tidyAll$年齡 == age & tidyAll$性別 == "女"),]$population
		tidyVoterZone[(tidyVoterZone$年齡 == age & tidyVoterZone$性別 == "女"),]$人口 <- sum(ageSubSet)
	}
	tidyVoterZone

	# Exploratory example : 
	# tidyVoterZoneMale <- tidyVoterZone[(tidyVoterZone$性別 == "男"),]
	# tidyVoterZonefemale <- tidyVoterZone[(tidyVoterZone$性別 == "女"),]

	# cumPopuplation <- cumsum(tidyVoterZoneMale$人口)
	# sumPopulation <- sum((tidyVoterZoneMale$人口))
	# halfMaleVoter <- tidyVoterZoneMale$年齡[length(cumPopuplation[(cumPopuplation <= sumPopulation*0.5)])]
	# cumPopuplation <- cumsum(tidyVoterZonefemale$人口)
	# sumPopulation <- sum((tidyVoterZonefemale$人口))
	# halfFemaleVoter <- tidyVoterZonefemale$年齡[length(cumPopuplation[(cumPopuplation <= sumPopulation*0.5)])]
	
	# halfLabelMale <- paste("50%男性小於", halfMaleVoter, "歲", sep="")
	# halfLabelFemale <- paste("50%女性小於", halfFemaleVoter, "歲", sep="")
	# plotTitle <- paste(cityName, "投票人口年齡分布", sep="")

	# png(file = "demographyLine.png", bg = "white", width = 720, height = 480)
	# ggplot(tidyVoterZone, aes(x=年齡, y=人口)) + 
	#     geom_line(aes(colour = 性別)) + 
	#     labs(title=plotTitle) +
	#     geom_vline(xintercept = c(halfMaleVoter, halfFemaleVoter)) + 
	#     annotate("text", label = c(halfLabelMale, halfLabelFemale), x = c(56,56), y = c(5000,10000), size = 4, colour = "red")
	# dev.off()
	
	# outputDate <- as.character(raw5$統計年月[1])
	# outputFileName <- raw5$區域別[1]
	# splitedChar <- ""
	# if(grepl("縣", outputFileName)){
	# 	splitedChar <- "縣"
	# }else if(grepl("市", outputFileName)){
	# 	splitedChar <- "市"
	# }
	# cityName <- unlist(strsplit(outputFileName, "市|縣", fixed = FALSE))[1]
	# fileName <- paste(outputDate, cityName, splitedChar, "人口資料tidy.csv", sep="")
	# write.csv(tidyVoterZone, file = fileName, row.names=FALSE, fileEncoding="UTF-8")
}

g0vDemo <- function(){
	dataFileList <- list.files(".")
	dataFileList <- dataFileList[grep("csv$", dataFileList)]
	for(file in dataFileList){
		raw <- readLines(file, encoding="UTF-8")
		raw2 <- read.csv(textConnection(paste0(raw, collapse="\n")),  header=FALSE, stringsAsFactors=FALSE)

		variableName <- raw2[1, 1:209]
		variableName[1,1] <- "統計年月"
		variableName[5] <- "總人口數"
		variableName[6] <- "總人口數男"
		variableName[7] <- "總人口數女"
		variableName <- sub("-", ".", variableName)

		names(raw2) <- variableName
		raw2 <- raw2[2:dim(raw2)[1], 1:dim(raw2)[2]-1]	
		raw2 <- raw2[(!is.na(raw2$統計年月)),]

		raw4 <- raw2[,c(8:dim(raw2)[2]-1)]
		raw4[,c(1:202)] <- lapply(raw4[,c(1:202)], as.numeric)

		raw5 <- raw2[,c(1:7)]
		raw5$M20_34 <- rowSums(raw4[,seq(from = 20*2+1, to = 34*2+1, by = 2)])
		raw5$F20_34 <- rowSums(raw4[,seq(from = 20*2+2, to = 34*2+2, by = 2)])
		raw5$M35_49 <- rowSums(raw4[,seq(from = 35*2+1, to = 49*2+1, by = 2)])
		raw5$F35_49 <- rowSums(raw4[,seq(from = 35*2+2, to = 49*2+2, by = 2)])
		raw5$M50_64 <- rowSums(raw4[,seq(from = 50*2+1, to = 64*2+1, by = 2)])
		raw5$F50_64 <- rowSums(raw4[,seq(from = 50*2+2, to = 64*2+2, by = 2)])
		raw5$M65_79 <- rowSums(raw4[,seq(from = 65*2+1, to = 79*2+1, by = 2)])
		raw5$F65_79 <- rowSums(raw4[,seq(from = 65*2+2, to = 79*2+2, by = 2)])
		raw5$M80up <- rowSums(raw4[,seq(from = 80*2+1, to = 100*2+1, by = 2)])
		raw5$F80up <- rowSums(raw4[,seq(from = 80*2+2, to = 100*2+2, by = 2)])

		raw5$投票人口男 <- rowSums(raw5[, grep("M", names(raw5), value=TRUE)])
		raw5$投票人口女 <- rowSums(raw5[, grep("F", names(raw5), value=TRUE)])

		outputDate <- as.character(raw5$統計年月[1])
		outputFileName <- raw5$區域別[1]
		splitedChar <- ""
		if(grepl("縣", outputFileName)){
			splitedChar <- "縣"
		}else if(grepl("市", outputFileName)){
			splitedChar <- "市"
		}
		cityName <- unlist(strsplit(outputFileName, "市|縣", fixed = FALSE))[1]
		fileName <- paste(outputDate, cityName, splitedChar, "人口資料.csv", sep="")
		write.csv(raw5, file = fileName, row.names=FALSE, fileEncoding="UTF-8")
	}
}