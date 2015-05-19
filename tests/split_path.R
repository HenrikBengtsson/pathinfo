library(pathinfo)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Aroma Framework
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# annotationData/
paths <- c(
  A = "annotationData/organisms/Homo_sapiens/Ensembl/79/",
  B = "../annotationData,shared/organisms/Homo_sapiens/Ensembl/79/",
  C = "C:\\hb\\..\\annotationData\\organism\\Homo_sapiens\\Ensembl\\79\\"
)

parts <- split_path(paths)
stopifnot(
  identical(names(parts), names(paths))
)
