mdata <- parse_folders("annotationData/organisms/Homo_sapiens/Ensembl/79/",
           patterns=c("**", rootpath="annotationData(|,.*)",
                      "organisms", organism=".*", "**"))
str(mdata)

str(as.list(mdata))

