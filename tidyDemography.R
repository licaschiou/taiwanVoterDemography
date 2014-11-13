dataFileList <- list.files(".")
dataFileList <- dataFileList[grep("csv$", dataFileList)]
##processFileList(dataFileList)
processFileList <- function(fileList = NULL){
	for(file in fileList){
		raw <- readLines(file, encoding="UTF-8")
		raw2 <- read.csv(textConnection(paste0(raw, collapse="\n")),  header=FALSE, stringsAsFactors=FALSE)

		variableName <- raw2[1,]
		variableName <- variableName[,1:209]
		raw3 <- raw2[2:457,]
		raw3 <- raw3[,1:209]

		variableName[1,1] <- "統計年月"
		names(raw3) <- variableName[1,]

		raw4 <- raw3[,c(1:7, 48:209)]
		raw4 <- raw3[,c(1:7, 48:209)]

		raw4[,c(8:169)] <- lapply(raw4[,c(8:169)], as.numeric)

		raw5 <- raw4[,c(1:7)]

		raw5$M20_34 <- rowSums(raw4[,seq(from = 8, to = 37, by = 2)])
		raw5$F20_34 <- rowSums(raw4[,seq(from = 9, to = 38, by = 2)])
		raw5$M35_49 <- rowSums(raw4[,seq(from = 38, to = 66, by = 2)])
		raw5$F35_49 <- rowSums(raw4[,seq(from = 39, to = 68, by = 2)])
		raw5$M50_64 <- rowSums(raw4[,seq(from = 68, to = 96, by = 2)])
		raw5$F50_64 <- rowSums(raw4[,seq(from = 69, to = 98, by = 2)])
		raw5$M65_79 <- rowSums(raw4[,seq(from = 98, to = 126, by = 2)])
		raw5$F65_79 <- rowSums(raw4[,seq(from = 99, to = 128, by = 2)])
		raw5$M80up <- rowSums(raw4[,seq(from = 128, to = 168, by = 2)])
		raw5$F80up <- rowSums(raw4[,seq(from = 129, to = 169, by = 2)])

		raw5$投票人口男 <- rowSums(raw5[, grep("M", names(raw5), value=TRUE)])
		raw5$投票人口女 <- rowSums(raw5[, grep("F", names(raw5), value=TRUE)])

		outputDate <- as.character(raw5$統計年月[1])
		outputFileName <- raw5$區域別[1]
		splitedChar <- ""
		if(grepl("市", outputFileName)){
			splitedChar <- "市"
		}else if(grepl("縣", outputFileName)){
			splitedChar <- "縣"
		}
		cityName <- unlist(strsplit(outputFileName, "市|縣", fixed = FALSE))[1]
		fileName <- paste(outputDate, cityName, splitedChar, "人口資料.csv", sep="")
		write.csv(raw5, file = fileName, row.names=FALSE, fileEncoding="UTF-8")
	}

}

processFile <- function(file = NULL){
	raw <- readLines(file, encoding="UTF-8")
	raw2 <- read.csv(textConnection(paste0(raw, collapse="\n")),  header=FALSE, stringsAsFactors=FALSE)

	variableName <- raw2[1,]
	variableName <- variableName[,1:209]
	raw3 <- raw2[2:457,]
	raw3 <- raw3[,1:209]

	variableName[1,1] <- "統計年月"
	names(raw3) <- variableName[1,]

	raw4 <- raw3[,c(1:7, 48:209)]
	raw4 <- raw3[,c(1:7, 48:209)]

	raw4[,c(8:169)] <- lapply(raw4[,c(8:169)], as.numeric)

	raw5 <- raw4[,c(1:7)]

	raw5$M20_34 <- rowSums(raw4[,seq(from = 8, to = 37, by = 2)])
	raw5$F20_34 <- rowSums(raw4[,seq(from = 9, to = 38, by = 2)])
	raw5$M35_49 <- rowSums(raw4[,seq(from = 38, to = 66, by = 2)])
	raw5$F35_49 <- rowSums(raw4[,seq(from = 39, to = 68, by = 2)])
	raw5$M50_64 <- rowSums(raw4[,seq(from = 68, to = 96, by = 2)])
	raw5$F50_64 <- rowSums(raw4[,seq(from = 69, to = 98, by = 2)])
	raw5$M65_79 <- rowSums(raw4[,seq(from = 98, to = 126, by = 2)])
	raw5$F65_79 <- rowSums(raw4[,seq(from = 99, to = 128, by = 2)])
	raw5$M80up <- rowSums(raw4[,seq(from = 128, to = 168, by = 2)])
	raw5$F80up <- rowSums(raw4[,seq(from = 129, to = 169, by = 2)])

	raw5$投票人口男 <- rowSums(raw5[, grep("M", names(raw5), value=TRUE)])
	raw5$投票人口女 <- rowSums(raw5[, grep("F", names(raw5), value=TRUE)])

	outputDate <- as.character(raw5$統計年月[1])
	outputFileName <- raw5$區域別[1]
	splitedChar <- ""
	if(grepl("市", outputFileName)){
		splitedChar <- "市"
	}else if(grepl("縣", outputFileName)){
		splitedChar <- "縣"
	}
	cityName <- unlist(strsplit(outputFileName, "市|縣", fixed = FALSE))[1]
	fileName <- paste(outputDate, cityName, splitedChar, "人口資料g0v.csv", sep="")
	write.csv(raw5, file = fileName, row.names=FALSE, fileEncoding="UTF-8")
}

