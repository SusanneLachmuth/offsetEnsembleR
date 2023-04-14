#' @title Calculate spatial offsets
#' @description Calculates contemporary spatial genomic offsets.

#' @param transEnv (dataframe) A dataframe holding transformed environmental variables of all occurrences of a species in a reference geographic region.
#' @param nCores (integer) Number of cores to be used in parallel computing. If defined, function will automatically perform in parallel. (default = NA).
#' @param nBreaks (integer) Number of chunks to subset 'transEnv'. Chunks will be sent to single cores. nBreaks should be equal or larger than nCores. If not defined while nCores is defined, nBreaks will be equal to nCores. (default = NA).
#' @param outpath (string) Paths to write results. If defined, results will automatically be written to disk. (default = NULL).
#' @param returnResult (boolean) if TRUE, data are (also) returned to the R environment independent of whether an outpath is specified. (default = TRUE).

#' @return A function of class ecdf (empirical cumulative distribution function). See help of stats package for more detail.

#' @examples
#' data(redSpruce_transClimate_spatialOffsets)
#' redSpruce_ecdfSpatialOffsets <- spatOffset(transEnv = redSpruce_transClimate_spatialOffsets)
#' # Plot eCDF
#' plot(redSpruce_ecdfSpatialOffsets)

#' @importFrom foreach %dopar%

#' @export
# Function
spatOffset <- function(transEnv,
                       nCores = NA,
                       nBreaks = NA,
                       outpath = NULL,
                       returnResult = TRUE){
  ## Run in parallel
  if(!is.na(nCores)){
    ### Checks if both nCores and nBreaks have been defined, if not sets nBreaks == nCores
    if(!is.na(nCores)&is.na(nBreaks)){
      nBreaks<-nCores
      warning("parallel computing has been chosen without setting the number of breaks (nBreaks) to split the input data, therefore nBreaks equal to nCores will be used")
    }
    ### Checks if nBreaks is equal or larger than nCores
    if(nBreaks<nCores){
      warning("nBreaks < nCores, consider setting nBreaks to a value equal or larger than nCores to ensure that all cores will be used")
    }
    ### Split transEnv data
    breakIt <- split(1:nrow(transEnv), cut(1:nrow(transEnv), nBreaks, labels = FALSE))
    ### Set up cluster
    cl <- parallel::makeCluster(nCores)
    doParallel::registerDoParallel(cl)
    ### Loop through transEnv subsets and calculate offsets (as Euclidean distances)
    spatOffset<- foreach::foreach(i = 1:length(breakIt), .packages = "fields") %dopar%{
      # Pairwise spatial offset matrix
      spatOffset_sub_mat<-fields::rdist(transEnv[breakIt[[i]],], transEnv)
      return(spatOffset_sub_mat)
    }
    parallel::stopCluster(cl)

    ### Call and format data
    spatOffset_out <- as.data.frame(do.call(rbind, spatOffset)) # as.df necessary?
    spatOffset_mat <- as.matrix(spatOffset_out) # necessary?

    ## Single core
  } else {
    ### Calculate pairwise spatial offset matrix
    spatOffset_mat <- rdist::pdist(transEnv)
  }

  ## Melt lower triangle of spatial offset matrix into long format
  spatOffset_lon <- reshape2::melt(spatOffset_mat)[reshape2::melt(lower.tri(spatOffset_mat))$value,]
  # Get empirical cumulative density function
  ecdfSpatOffset <- stats::ecdf(spatOffset_lon$value)

  ## Write to disk if outpath is defined
  if (!is.null(outpath)){
    save(ecdfSpatOffset,file=paste0(outpath,"cdfSpatOffset.Rdata"))
  }
  ## Return to workspace if outpath is not defined or returnResult==TRUE
  if(is.null(outpath)||returnResult){
    return(ecdfSpatOffset)
  }
}
