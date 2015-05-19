#' Split paths into vectors of folders and files
#'
#' @param paths A vector of paths
#' @param drop If TRUE and \code{paths} is a single path,
#'        then a vector and not a list of vectors is returned.
#' @param ... Not used.
#'
#' @return Returns a list of character vectors, unless \code{drop}
#' is TRUE in case a single character vectors is returned.
#'
#' @export
split_path <- function(paths, drop=TRUE, ...) {
  parts <- strsplit(paths, split="[/\\]", fixed=FALSE)
  if (drop && length(parts) == 1L) parts <- parts[[1L]]
  parts
}
