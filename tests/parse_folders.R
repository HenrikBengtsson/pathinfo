library(pathinfo)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Aroma Framework
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# annotationData/
paths <- c(
  "annotationData/organisms/Homo_sapiens/Ensembl/79/",
  "../annotationData,shared/organisms/Homo_sapiens/Ensembl/79/",
  "C:/hb/../annotationData/organism/Homo_sapiens/Ensembl/79/"
)

patterns <- c("**", rootpath="annotationData(|,.*)", "organisms",
              organism=".*", "**")
for (kk in seq_along(paths)) {
  print(paths[kk])
  mraw <- parse_folders(paths[kk], patterns=patterns, mustWork=FALSE)
  str(mraw)
  mdata <- as.list(mraw)
  str(mdata)
  stopifnot(mdata$organism == "Homo_sapiens")
}

# rawData/ and probeData/
paths <- c(
  "rawData/MyDataSet,UCSF/GenomeWideSNP_6/",
  "rawData,shared/MyDataSet/GenomeWideSNP_6/",
  "probeData/MyDataSet,UCSF,ACC/Mapping250K_Nsp/"
)

patterns <- c("**", rootpath="(raw|probe)Data(|,.*)",
                    dataset=".*", chiptype=".*")
for (kk in seq_along(paths)) {
  print(paths[kk])
  mraw <- parse_folders(paths[kk], patterns=patterns, mustWork=FALSE)
  str(mraw)
  mdata <- as.list(mraw)
  str(mdata)
  stopifnot(
    grepl("MyDataSet", mdata$dataset),
    mdata$chiptype %in% c("GenomeWideSNP_6", "Mapping250K_Nsp")
  )
}

