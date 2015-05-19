library(pathinfo)

paths <- c(
  "C:/hb/../annotationData/organism/Homo_sapiens/Ensembl/79/",
  "../annotationData/organisms/Homo_sapiens/Ensembl/79/",
  "annotationData/organisms/Homo_sapiens/Ensembl/79/"
)

patterns <- c("**", rootPath="annotationData(|,.*)", "organisms",
              organism=".*", "**")
for (kk in seq_along(paths)) {
  print(paths[kk])
  mdata <- parse_folders(paths[kk], patterns=patterns, mustWork=FALSE)
  str(mdata)
  str(as.list(mdata))
}

