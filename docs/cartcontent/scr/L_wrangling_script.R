# 24.08.2022
# script to wrangle output from tools



table1 <- read.table("~/Dropbox/Research/Projects/Ongoing/CAR_target_assessment/subset_data_c2/table1/table1.txt", header=TRUE, sep="\t")
renames <- scan("~/Dropbox/Research/Projects/Ongoing/CAR_target_assessment/subset_data_c2/table1/rename-1.txt", what="list")
table1$uniprot <- as.character(table1$uniprot)
table1[table1$uniprot %in% renames,]$uniprot <- gsub("-\\d", "", table1[table1$uniprot %in% renames,]$uniprot, perl=TRUE)

deeploc_res <- read.table("~/Dropbox/Research/Projects/Ongoing/CAR_target_assessment/subset_data_c2/table1/deeploc_res.txt", header = TRUE, sep="\t")
topcons_res <- read.table("cartcontent/results/Topcons/ALPP/seq_0/Topcons/topcons.top", header = TRUE, sep="\t")
signalp_res <- read.table("cartcontent/results/SignalP/ALPP.txt", header = TRUE, sep="\t")

# deeploc
# deeploc_res <- deeploc_res[table1[table1$loc=="",]$uniprot %in% deeploc_res$uniprot,]
deeploc_res$loc <- paste0(deeploc_res$loc, "*")
table1_update <- merge(table1,deeploc_res, by = "uniprot", all.x=TRUE)

# topcons
# topcons_res <- topcons_res[table1[is.na(table1$ecto),]$uniprot %in% topcons_res$uniprot,]
library(stringr)
topcons_res$ecto <- apply(topcons_res, 1, function(x) str_count(x[1], "o"))
topcons_res$ecto <- str_count(topcons_res, "o")
topcons_res$ecto <- paste0(topcons_res$ecto, "*")
table1_update <- merge(table1_update,topcons_res, by = "uniprot", all.x=TRUE)

# Signalp
# signalp_res <- signalp_res[table1[table1$signalp=="",]$uniprot %in% signalp_res$uniprot,]
table1_update <- merge(table1_update,signalp_res, by = "uniprot", all.x=TRUE)

write.table(table1_update, file="~/Dropbox/Research/Projects/Ongoing/CAR_target_assessment/subset_data_c2/table1/table1_update.txt", row.names = FALSE, col.names = TRUE, quote=FALSE, sep="\t")


#COPY


table1 <- read.table("~/Dropbox/Research/Projects/Ongoing/CAR_target_assessment/subset_data_c2/table1/table1.txt", header=TRUE, sep="\t")
renames <- scan("~/Dropbox/Research/Projects/Ongoing/CAR_target_assessment/subset_data_c2/table1/rename-1.txt", what="list")
table1$uniprot <- as.character(table1$uniprot)
table1[table1$uniprot %in% renames,]$uniprot <- gsub("-\\d", "", table1[table1$uniprot %in% renames,]$uniprot, perl=TRUE)

deeploc_res <- read.table("~/Dropbox/Research/Projects/Ongoing/CAR_target_assessment/subset_data_c2/table1/deeploc_res.txt", header = TRUE, sep="\t")
topcons_res <- read.table("~/Dropbox/Research/Projects/Ongoing/CAR_target_assessment/subset_data_c2/table1/topcons_res.txt", header = TRUE, sep="\t")
signalp_res <- read.table("~/Dropbox/Research/Projects/Ongoing/CAR_target_assessment/subset_data_c2/table1/signalp_res.txt", header = TRUE, sep="\t")

# deeploc
# deeploc_res <- deeploc_res[table1[table1$loc=="",]$uniprot %in% deeploc_res$uniprot,]
deeploc_res$loc <- paste0(deeploc_res$loc, "*")
table1_update <- merge(table1,deeploc_res, by = "uniprot", all.x=TRUE)

# topcons
# topcons_res <- topcons_res[table1[is.na(table1$ecto),]$uniprot %in% topcons_res$uniprot,]
library(stringr)
topcons_res$ecto <- apply(topcons_res, 1, function(x) str_count(x[3], "o"))
topcons_res$ecto <- paste0(topcons_res$ecto, "*")
table1_update <- merge(table1_update,topcons_res, by = "uniprot", all.x=TRUE)

# Signalp
# signalp_res <- signalp_res[table1[table1$signalp=="",]$uniprot %in% signalp_res$uniprot,]
table1_update <- merge(table1_update,signalp_res, by = "uniprot", all.x=TRUE)

write.table(table1_update, file="~/Dropbox/Research/Projects/Ongoing/CAR_target_assessment/subset_data_c2/table1/table1_update.txt", row.names = FALSE, col.names = TRUE, quote=FALSE, sep="\t")