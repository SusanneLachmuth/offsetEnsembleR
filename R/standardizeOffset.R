#' @title Standardize genomic offsets
#' @description Standardizes raw genomic offsets based on methods presented by Lachmuth et al. (in review). First, offsets are
#'expressed  as probabilities of the distribution of spatial genomic offsets obtained using the 'spatOffset' function. Second, the
#'probabilities are converted to percentiles of a chi distribution with one degree of freedom (quantile normalization).

#' @param rawOffset (dataframe) A dataframe holding pairwise raw offsets.
#' @param cdf (function) Cumulative density function of spatial offsets.
#' @param nCores (integer) Number of cores to be used in parallel computing. If defined function will automatically perform in parallel. (default = NA).
#' @param nBreaks (integer) Number of chunks to subset 'rawOffset'. Chunks will be sent to single cores. nBreaks should be equal or larger than nCores. If not defined while nCores is defined, nBreaks will be equal to nCores. (default = NA).
#' @param outpath (string) Paths to write results. If defined, results will automatically be written to disk. (default = NULL).
#' @param returnResult (boolean) if TRUE, data are (also) returned to the R environment independent of whether an outpath is specified. (default = TRUE).
#' @param returnOffsetProb (boolean) if TRUE, a matrix with offset probabilities (drawn from cfd) is also returned.
#'Caution:will double the required disk space and memory! (default = FALSE).
#'
#' @return A dataframe with offset z-scores (sigma). Dataframe columns and rows are identical with those of the rawOffset input file.
#'Optionally, the offset probabilities calculated in step 1 can be returned as well.
#'
#' @examples
#' # Sampled red spruce populations as donors and Blue Ridge ecoregion as recipients
#' data(redSprucePops_blueRidge_rawOffset)
#' data(redSpruce_ecdfSpatialOffsets)
#'
#' # Standardize raw spatio-temoral offsets
#' redSprucePops_blueRidge_standardizedOffset <-
#' standardizeOffset(rawOffset = redSprucePops_blueRidge_rawOffset,
#' cdf = redSpruce_ecdfSpatialOffsets)
#'
#' # View results
#' redSprucePops_blueRidge_standardizedOffset[1:10,1:10]

#' @importFrom foreach %dopar%

#' @export
# Function
standardizeOffset <- function(rawOffset,
                              cdf,
                              nCores = NA,
                              nBreaks = NA,
                              outpath = NULL,
                              returnResult = TRUE,
                              returnOffsetProb = FALSE){
  if(!is.na(nCores)){
    ### Checks if both nCores and nBreaks have been defined, if not sets nBreaks == nCores
    if(!is.na(nCores)&is.na(nBreaks)){
      nBreaks<-nCores
      warning("parallel computing has been chosen without setting the number of breaks (nBreaks) to split the input data, therefore nBreaks equals nCores")
    }
    ### Checks if nBreaks is equal or larger than nCores
    if(nBreaks<nCores){
      warning("nBreaks < nCores, consider setting nBreaks to a value equal or larger than nCores to ensure that all cores will be used")
    }

    breakIt<- split(1:nrow(rawOffset), cut(1:nrow(rawOffset), nBreaks, labels = FALSE))

    # Run in parallel
    cl <- parallel::makeCluster(nCores)
    doParallel::registerDoParallel(cl)

    standOffset <- foreach::foreach(i = 1:length(breakIt),  .packages= c("stats", "adehabitatLT")) %dopar%{
      offset_sub<-rawOffset[breakIt[[i]],]
      if(returnOffsetProb == FALSE){
        out <- apply(offset_sub, 2, FUN=function(x){
          sigma <- adehabitatLT::qchi(cdf(x),1)
        })

      } else {
        offset_prob <- apply(offset_sub, 2, FUN=function(x){
          offset_probabilty <- cdf(x)
        })
        offset_sigma <- apply(offset_prob, 2, FUN=function(x){
          offset_sigmavalue <- adehabitatLT::qchi(x,1)
        })
        out<-list(offset_prob,offset_sigma)
      }
      return(out)
    }
    parallel::stopCluster(cl)

    if (returnOffsetProb == FALSE){
      offset_sigma_out<-as.data.frame(do.call(rbind, standOffset))
      rownames(offset_sigma_out)<-rownames(rawOffset)
    }

    if (returnOffsetProb == TRUE){
      offset_prob<-as.data.frame(do.call(rbind, lapply(standOffset, function(x) x[[1]])))
      rownames(offset_prob) <- colnames(offset_prob) <- rownames(rawOffset)
      offset_sigma<-as.data.frame(do.call(rbind, lapply(standOffset, function(x) x[[2]])))
      rownames(offset_sigma) <- rownames(rawOffset)
      colnames(offset_sigma) <- colnames(rawOffset)
    }

    # non-parallel
  } else {
    offset_prob <-apply(rawOffset, 2, FUN=function(x){
      offset_probabilty <- cdf(x)})
    rownames(offset_prob) <- rownames(rawOffset)
    colnames(offset_prob) <- colnames(rawOffset)
    offset_sigma <- adehabitatLT::qchi(offset_prob,1)
  }

  # Return and / or save objects
  if(returnOffsetProb == FALSE){ # Return / save offset_sigma only
    #rm(offset_prob)
    if (!is.null(outpath)){
      save(offset_sigma,file=paste0(outpath,"offset_sigma.Rdata"))
    }
    if(is.null(outpath)||returnResult){
      return(offset_sigma)
    }
  } else { # Return / save both offset_prob and offset_sigma
    if (!is.null(outpath)){
      save(offset_prob,file=paste0(outpath,"offset_prob.Rdata"))
      save(offset_sigma,file=paste0(outpath,"offset_sigma.Rdata"))
    }
    if(is.null(outpath)||returnResult){
      return(list(offset_prob,offset_sigma))
    }
  }
}
