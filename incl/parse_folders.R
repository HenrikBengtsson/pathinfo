message("parse_folders():")
mdata <- parse_folders("annotationData/organisms/Homo_sapiens/Ensembl/79/",
           patterns=c("**", rootpath="annotationData(|,.*)",
                      "organisms", organism=".*", "**"))
str(mdata)

message("as.list(mdata):")
str(as.list(mdata))

