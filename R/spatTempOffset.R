#'@title Calculate (spatio-)temporal offsets
#'@description Calculates raw genomic offsets.

#'@param transEnv (dataframe) A dataframe holding transformed environmental variables.
#'@param transAltEnv (dataframe) A dataframe holding transformed altered environmental variables.
#'@param nCores (integer) Number of cores to be used in parallel computing. If defined, function will automatically perform in parallel. (default = NA).
#'@param nBreaks (integer) Number of chunks to subset rawOffset. Chunks will be sent to single cores. nBreaks should be equal or larger than nCores. If not defined while nCores is defined, nBreaks will be equal to nCores. (default = NA).
#'@param outpath (string) Paths to write results. If defined, results will automatically be written to disk. (default = NULL).
#'@param returnResult (boolean) if TRUE, data are (also) returned to the R environment independent of whether an outpath is specified. (default = TRUE).

#'@return A dataframe with pair-wise genomic offsets. Columns in the rawOffset output dataframe correspond to rows of transEnv, rows of output correspond to rows of transAltEnv.

#'@examples
#' # Example 1: sampled red spruce populations are both donors and recipients
#' data(redSprucePops_transClimate)
#' data(redSprucePops_transAlteredClimate)
#'
#' # Calculate raw spatio-temporal offsets
#' redSprucePops_rawOffset <- spatTempOffset(transEnv = redSprucePops_transClimate,
#' transAltEnv = redSprucePops_transAlteredClimate, nCores = NA, nBreaks = NA, outpath = NULL)
#'
#' # View result
#' redSprucePops_rawOffset[1:10,1:10]
#'
#' # Get local offsets (only works this way if rows and columns are identical locations)
#' redSprucePops_localOffset<-diag(as.matrix(redSprucePops_rawOffset))
#' redSprucePops_localOffset
#'
#' #' # Example 2: sampled red spruce populations as donors and Blue Ridge ecoregion as recipients
#' data(redSprucePops_transClimate)
#' data(blueRidge_transAlteredClimate)
#'
#' # Calculate raw spatio-temporal offsets
#' redSprucePops_blueRidge_rawOffset <- spatTempOffset(transEnv = redSprucePops_transClimate,
#' transAltEnv = blueRidge_transAlteredClimate, nCores = NA, nBreaks = NA, outpath = NULL)
#'
#' # View result
#' redSprucePops_blueRidge_rawOffset[1:10,1:10]


#'@export
spatTempOffset <- function(transEnv, transAltEnv, nCores = NA, nBreaks = NA, outpath = NULL, returnResult = TRUE){
  # Run in parallel
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

    # Split data
    breakIt <- split(1:nrow(transAltEnv), cut(1:nrow(transAltEnv), nCores, nBreaks, labels = FALSE))

    # Set up cluster
    cl <- parallel::makeCluster(nCores)
    doParallel::registerDoParallel(cl)

    rawOffset <- foreach::foreach(i = 1:length(breakIt), .packages = "fields") %dopar%{
      # Calculate pairwise offset matrix
      rawOffset<-fields::rdist(transAltEnv[breakIt[[i]],], transEnv)
      return(rawOffset)
    }
    parallel::stopCluster(cl)

    # Call and format data
    rawOffset<- as.data.frame(do.call(rbind, rawOffset))


  } else {
    rawOffset<-as.data.frame(fields::rdist(transAltEnv,transEnv))
  }

  # Make sure that rows and columns have correct names
  colnames(rawOffset)<-rownames(transEnv) # necessary!
  rownames(rawOffset)<-rownames(transAltEnv) # necessary!

  # Write to disk if outpath is defined
  if (!is.null(outpath)){
    save(rawOffset,file=paste0(outpath,"rawOffset.Rdata"))
  }
  # Return to workspace if outpath is not defined or returnResult==TRUE
  if(is.null(outpath)||returnResult){
    return(rawOffset)
  }

}
