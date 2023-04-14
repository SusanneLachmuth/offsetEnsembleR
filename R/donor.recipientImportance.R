#' @title Donor and recipient importance
#' @description Calculates pairwise transferability between donor and recipient locations as well as donor and recipient importance. Donor Importance for each donor location is calculated as the percentage of recipient locations with a (standardized) offset below a 'not-to-exceed' offset threshold. Recipient Importance of each potential recipient locations represents the percentage of donor cells with a standardized offset below the offset threshold when paired with this recipient.

#' @param standOffset (dataframe) A dataframe holding pairwise (standardized) offsets between donor and recipient locations.
#' @param offsetThreshold (double) 'not to exceed' (standardized) offset threshold when evaluating transferability between donor and recipient locations.
#' @param nCores (integer) Number of cores to be used in parallel computing. If defined function will automatically perform in parallel. (default = NA).
#' @param nBreaks (integer) Number of chunks to subset 'standOffset'. Chunks will be sent to single cores. nBreaks should be equal or larger than nCores. If not defined while nCores is defined, nBreaks will be equal to nCores. (default = NA).
#' @param outpath (string) Paths to write results. If defined, results will automatically be written to disk. (default = NULL).
#' @param returnResult (boolean) if TRUE, data are (also) returned to the R environment independent of whether an outpath is specified. (default = TRUE).
#' @param returnTransferabilityMatrix (boolean) if TRUE, a binary transferability matrix between donors and recipients is also returned.
#'Caution: will highly increase the required disk space and memory! (default = FALSE).

#' @return Two dataframes: 1) Donor importance, 2) Recipient importance. Row names of the output files allow connecting donor and recipient importance values to geographic locations.
#' Optionally, the binary transferability matrix calculated in step 1 can be returned as well.

#' @examples
#' data(redSprucePops_blueRidge_standardizedOffset)
#' redSprucePops_blueRidge_DI_RI <-
#' donor.recipientImportance(standOffset = redSprucePops_blueRidge_standardizedOffset,
#' offsetThreshold = 1, returnTransferabilityMatrix = TRUE)
#'
#' # view tranferability matrix:
#' redSprucePops_blueRidge_DI_RI[[1]][1:10,1:10]
#'
#' # view donor importance:
#' redSprucePops_blueRidge_DI_RI[[2]][1:10,]
#'
#' # Map recipient importance
#' # Will need to find a way of mapping without depending on sf
#' #require(ggplot2)
#' #require(maps)
#' #load(blueRidge_transAlteredClimate)
#'
#' # Get latitude and longitude
#' #dat<-cbind(blueRidge_transAlteredClimate[,1:2],redSprucePops_blueRidge_DI_RI[[3]])
#' #mycolors<- inlmisc::GetTolColors(n = 256,scheme = "smooth rainbow")
#'
#' #map_RecImp<- ggplot2::ggplot() +
#'  #geom_sf(data = world, fill="ivory", color=NA, size=0.3) +
#'  #geom_tile(data = dat, aes(x=x, y=y, fill=recipientImportance)) +
#'  #scale_fill_gradientn(limits = c(0,100),colors = mycolors,
#'  #name ="Recipient importance (%)", guide = "colorbar" ) +
#'  #geom_sf(data = lakes, fill="#A6CAE0", size=0.3)+
#'  #geom_sf(data = world, fill=NA, color="black", size=0.3) +
#'  #coord_sf(xlim = c(-90, -70), ylim = c(30, 43), expand = FALSE)+
#'  #xlab("Longitude") +
#'  #ylab("Latitude") +
#'  #theme_minimal()
#' #map_RecImp

#' @importFrom foreach %dopar%

#' @export
# Function
donor.recipientImportance <- function(standOffset, # use different name since raw offsets might be used when coming e.g. from RDA
                                      offsetThreshold = 1,
                                      nCores = NA,
                                      nBreaks = NA,
                                      outpath = NULL,
                                      returnResult = TRUE,
                                      returnTransferabilityMatrix = FALSE)
{

  ##checks to see if offsetThreshold is numeric
  if(!is.numeric(offsetThreshold)){
    stop("offsetThreshold must be numeric.")
  }

  ## Run in parallel
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

    breakIt <- split(1:nrow(standOffset), cut(1:nrow(standOffset), nBreaks, labels = FALSE))

    # Run in parallel
    cl <- parallel::makeCluster(nCores)
    doParallel::registerDoParallel(cl)

    applySigmaTH <- foreach::foreach(i = 1:length(breakIt)) %dopar%{
      standOffset_sub<-standOffset[breakIt[[i]],]
      transferability_sub <- apply(standOffset_sub, 2, FUN=function(x){
        transferability <- ifelse(x <= offsetThreshold,1,0)
      })
      return(transferability_sub)
    }
    parallel::stopCluster(cl)

    # Call and format data
    transferabilityMatrix <- as.data.frame(do.call(rbind, applySigmaTH))

    # Non-parallel
  }else{
    transferabilityMatrix <- apply(standOffset, 2, FUN=function(x){
      transferability <- ifelse(x <= offsetThreshold,1,0)})
  }



  # Calculate donor and recipient importance and store in separate data frames
  donorImportance <- data.frame(donorImportance = (colSums(transferabilityMatrix, na.rm = T) / nrow(transferabilityMatrix) * 100), row.names = colnames(standOffset))
  recipientImportance <- data.frame(recipientImportance = (rowSums(transferabilityMatrix, na.rm = T) / ncol(transferabilityMatrix) * 100), row.names = rownames(standOffset))

  # Save or return data
  ## Donor and recipient importance only
  if(returnTransferabilityMatrix == FALSE){
    rm(transferabilityMatrix)
    ### Save to disk
    if (!is.null(outpath)){
      save(donorImportance, file = paste0(outpath, "donorImportance.Rdata"))
      save(recipientImportance, file = paste0(outpath, "recipientImportance.Rdata"))
    }
    ### Return to workspace
    if(is.null(outpath)||returnResult){
      return(list(donorImportance, recipientImportance))
    }
    ## Including transferability matrix
  } else {
    if (!is.null(outpath)){
      save(transferabilityMatrix, file = paste0(outpath, "transferabilityMatrix.Rdata"))
      save(donorImportance, file = paste0(outpath, "donorImportance.Rdata"))
      save(recipientImportance, file = paste0(outpath, "recipientImportance.Rdata"))
    }
    if(is.null(outpath)||returnResult){
      return(list(transferabilityMatrix, donorImportance, recipientImportance))
    }
  }

}
