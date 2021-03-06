% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/parse_folders.R
\name{parse_folders}
\alias{parse_folders}
\title{Parses a directory structure}
\usage{
parse_folders(path, patterns, mustWork = TRUE, ...)
}
\arguments{
\item{path}{The path}

\item{patterns}{A vector of regular expressions}

\item{mustWork}{If TRUE, an error is thrown if \code{path}
does not match \code{patterns}.}

\item{...}{Not used}
}
\description{
Parses a directory structure
}
\examples{
mdata <- parse_folders("annotationData/organisms/Homo_sapiens/Ensembl/79/",
           patterns=c("**", rootpath="annotationData(|,.*)",
                      "organisms", organism=".*", "**"))
str(mdata)

str(as.list(mdata))

}

