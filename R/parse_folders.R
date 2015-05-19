#' Parses a directory structure
#'
#' @param path The path
#' @param patterns A vector of regular expressions
#' @param mustWork If TRUE, an error is thrown if \code{path}
#'        does not match \code{patterns}.
#' @param ... Not used
#'
#' @example incl/parse_folders.R
#'
#' @export
parse_folders <- function(path, patterns, mustWork=TRUE, ...) {
  parts <- split_path(path, drop=TRUE)
  nparts <- length(parts)
  keys <- names(patterns)

  ## Default result
  res <- structure(vector("list", length=length(patterns)), path=path, class="ParsedFolders")

  names(res) <- keys
  for (ii in seq_along(patterns)) {
    res[[ii]] <- list(name=keys[ii], pattern=unname(patterns[ii]), value=NA_character_)
  }

  ## Folders to locate
  idxs <- which(!is.element(patterns, c("*", "**")))

  ## For each item to be found...
  pidx <- 1L
  for (idx in idxs) {
    key <- keys[idx]
    pattern <- patterns[idx]

    ## Out of bound = incomplete?
    if (pidx > nparts) {
      if (!mustWork) {
        pidx <- pidx + 1L
        next
      }
      stop(sprintf("Failed to locate pathname part %s such that it matches regular expression %s and all parts have been consumed: %s", sQuote(key), sQuote(pattern), sQuote(path)))
    }

    ## Are we allowed to skip/look ahead?
    prevPattern <- patterns[idx-1L]
    hasPrevPattern <- (length(prevPattern) == 1L &&
                       is.element(prevPattern, c("*", "**")) &&
                       pidx < nparts)
    if (hasPrevPattern) {
      if (prevPattern == "*") {
        pidxs <- pidx:(pidx+1L)
      } else if (prevPattern == "**") {
        pidxs <- pidx:nparts
      }
    } else {
      pidxs <- pidx
    }

    ## Locate
    idxP <- grep(pattern, parts[pidxs])[1]

    ## Failed to locate?
    if (!is.finite(idxP)) {
      if (!mustWork) {
        pidx <- pidx + 1L
        next
      }
      stop(sprintf("Failed to locate pathname part %s such that it matches regular expression %s: %s", sQuote(key), sQuote(pattern), sQuote(path)))
    }

    ## Record
    if (hasPrevPattern) {
      if (idxP > 1L) {
        res[[idx-1L]]$value <- parts[pidxs][1:(idxP-1)]
      } else {
        res[[idx-1L]]$value <- character(0L)
      }
    }
    res[[idx]]$value <- parts[pidxs][idxP]

    ## Next
    pidx <- pidxs[idxP] + 1L
  } # for (idx ...)

  ## Any remaining parts?
  if (idx < length(patterns)) {
    for (idx in (idx+1):length(patterns)) res[[idx]]$value <- character(0L)
  }


  ## Sanity checks
  stopifnot(length(res) == length(patterns))

  res
} # parse_folders()


#' @export
as.list.ParsedFolders <- function(x, drop=TRUE, ...) {
  x <- unclass(x)
  names <- sapply(x, FUN=.subset2, "name")
  values <- lapply(x, FUN=.subset2, "value")
  names(values) <- names

  ## Drop '*' and '**' patterns and those without names
  if (drop) {
    patterns <- lapply(x, FUN=.subset2, "pattern")
    values <- values[!is.element(patterns, c("*", "**"))]
    values <- values[nzchar(names(values))]
  }

  values
}

#' @export
as.data.frame.ParsedFolders <- function(x, ...) {
  path <- attr(x, "path")
  x <- as.list(x, drop=TRUE)
  cbind(path=path, as.data.frame(x))
}

