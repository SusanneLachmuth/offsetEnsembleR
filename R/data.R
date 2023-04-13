#' @title Transformed current climate for Southern Appalachian red spruce populations
#'
#' @description A data set containing Gradient Forest transformed reference climate normals (1961-1990)
#' for sites with red spruce populations in the Southern Appalachian mountains (latitudes < 40°).
#' The original climate variables were transformed using Gradient Forest turnover functions.
#' The Gradient Forest model was fit to data SNP candidate data for the same populations.
#' The transformations provide a common biological scale of compositional turnover (in this case, turnover in allele frequencies),
#' thereby allowing conversion from multidimensional climatic space to multidimensional genetic space
#' while selecting and weighting variables such that they best summarize genomic variation.
#' Please not that due to the transformation the variables are unitless.
#' Population IDs are given as row names.
#'
#' @format A data frame with 25 rows and 11 variables:
#' \describe{
#'   \item{CMD}{Hargreaves climatic moisture deficit}
#'   \item{DD_0}{degree-days below 0°C, chilling degree-days}
#'   \item{DD18}{degree-days above 18°C, cooling degree-days}
#'   \item{eFFP}{the day of the year on which the Frost Free Period ends}
#'   \item{EXT}{extreme maximum temperature over 30 years}
#'   \item{MAR}{mean annual solar radiation}
#'   \item{MSP}{mean summer precipitation}
#'   \item{PAS}{precipitation as snow}
#'   \item{PET}{potential evapotranspiration}
#'   \item{RH}{mean annual relative humidity}
#'   \item{TD}{continentality}
#' }
#'
#' @usage data(redSprucePops_transClimate)
#'
#' @source <https://climatena.ca>
#' <https://envirem.github.io>
"redSprucePops_transClimate"

#' @title Transformed future climate for Southern Appalachian red spruce populations
#'
#' @description A data set containing Gradient Forest transformed future climate normals (2071-2100)
#' for sites with red spruce populations in the Southern Appalachian mountains (latitudes < 40°).
#' The original climate variables were transformed using Gradient Forest turnover functions.
#' The Gradient Forest model was fit to data SNP candidate data for the same populations.
#' The transformations provide a common biological scale of compositional turnover (in this case, turnover in allele frequencies),
#' thereby allowing conversion from multidimensional climatic space to multidimensional genetic space
#' while selecting and weighting variables such that they best summarize genomic variation.
#' Please not that due to the transformation the variables are unitless.
#' Population IDs are given as row names.
#'
#' @format A data frame with 25 rows and 11 variables:
#' \describe{
#'   \item{CMD}{Hargreaves climatic moisture deficit}
#'   \item{DD_0}{degree-days below 0°C, chilling degree-days}
#'   \item{DD18}{degree-days above 18°C, cooling degree-days}
#'   \item{eFFP}{the day of the year on which the Frost Free Period ends}
#'   \item{EXT}{extreme maximum temperature over 30 years}
#'   \item{MAR}{mean annual solar radiation}
#'   \item{MSP}{mean summer precipitation}
#'   \item{PAS}{precipitation as snow}
#'   \item{PET}{potential evapotranspiration}
#'   \item{RH}{mean annual relative humidity}
#'   \item{TD}{continentality}
#' }
#'
#' @usage data(redSprucePops_transAlteredClimate)
#'
#' @source <https://climatena.ca>
#' <https://envirem.github.io>
"redSprucePops_transAlteredClimate"


#' @title Transformed future climate for the Appalachian Blue Ridge Forest ecoregion
#'
#' @description A data set containing Gradient Forest transformed future climate normals (2071-2100)
#' for the Appalachian Blue Ridge Forest ecoregion at a resolution of 2.5 arcminutes.
#' The original climate variables were transformed using Gradient Forest turnover functions.
#' The Gradient Forest model was fit to data SNP candidate data for Southern Appalachian red spruce populations.
#' The transformations provide a common biological scale of compositional turnover (in this case, turnover in allele frequencies),
#' thereby allowing conversion from multidimensional climatic space to multidimensional genetic space
#' while selecting and weighting variables such that they best summarize genomic variation.
#' Please not that due to the transformation the variables are unitless.
#'
#' @format A data frame with 25 rows and 11 variables:
#' \describe{
#'   \item{CMD}{Hargreaves climatic moisture deficit}
#'   \item{DD_0}{degree-days below 0°C, chilling degree-days}
#'   \item{DD18}{degree-days above 18°C, cooling degree-days}
#'   \item{eFFP}{the day of the year on which the Frost Free Period ends}
#'   \item{EXT}{extreme maximum temperature over 30 years}
#'   \item{MAR}{mean annual solar radiation}
#'   \item{MSP}{mean summer precipitation}
#'   \item{PAS}{precipitation as snow}
#'   \item{PET}{potential evapotranspiration}
#'   \item{RH}{mean annual relative humidity}
#'   \item{TD}{continentality}
#' }
#'
#' @usage data(blueRidge_transAlteredClimate)
#'
#' @source <https://climatena.ca>
#' <https://envirem.github.io>
#' <https://www.oneearth.org/ecoregions/appalachian-blue-ridge-forests/>
"blueRidge_transAlteredClimate"


#' @title Transformed future climate for the Appalachian Blue Ridge Forest ecoregion
#'
#' @description A data set containing Gradient Forest transformed reference climate normals (1961-1990)
#' for Southern Appalachian red spruce occurrences (latitudes <40°N).
#' The original climate variables were transformed using Gradient Forest turnover functions.
#' The Gradient Forest model was fit to data SNP candidate data for Southern Appalachian red spruce populations.
#' The transformations provide a common biological scale of compositional turnover (in this case, turnover in allele frequencies),
#' thereby allowing conversion from multidimensional climatic space to multidimensional genetic space
#' while selecting and weighting variables such that they best summarize genomic variation.
#' Please not that due to the transformation the variables are unitless.
#'
#' @format A data frame with 25 rows and 11 variables:
#' \describe{
#'   \item{CMD}{Hargreaves climatic moisture deficit}
#'   \item{DD_0}{degree-days below 0°C, chilling degree-days}
#'   \item{DD18}{degree-days above 18°C, cooling degree-days}
#'   \item{eFFP}{the day of the year on which the Frost Free Period ends}
#'   \item{EXT}{extreme maximum temperature over 30 years}
#'   \item{MAR}{mean annual solar radiation}
#'   \item{MSP}{mean summer precipitation}
#'   \item{PAS}{precipitation as snow}
#'   \item{PET}{potential evapotranspiration}
#'   \item{RH}{mean annual relative humidity}
#'   \item{TD}{continentality}
#' }
#'
#' @usage data(redSpruce_transClimate_spatialOffsets)
#'
#' @source <https://climatena.ca>
#' <https://envirem.github.io>
"redSpruce_transClimate_spatialOffsets"

#' @title Empirical cumulative distribution function of spatial offsets
#'
#' @description Empirical cumulative distribution function of contemporary spatial offsets among Southern Appalachian red spruce occurrences
#' created using the spatOffset function and the 'redSpruce_transClimate_spatialOffsets' data set.
#'
#' @format A function computed using the ecdf function of the 'stats' package.
#' \describe{
#'   \item{redSpruce_ecdfSpatialOffsets}{a step function with jumps i/n at observation values, where i is the number of tied spatial offset observations at that value.}
#' }
#'
#' @usage data(redSpruce_ecdfSpatialOffsets)
"redSpruce_ecdfSpatialOffsets"

#' @title Pairwise genomic offset between red spruce populations under current and future climates
#'
#' @description Raw spatio-temporal offsets between southern Appalachian red spruce populations under current and future climate.
#' Calculated using the \code{\link[offsetEnsembleR]{spatTempOffset}} function and \code{\link[offsetEnsembleR]{redSprucePops_transClimate}} and
#' \code{\link[offsetEnsembleR]{redSprucePops_transAlteredClimate}} data sets.
#'
#' @format A matrix of pairwise raw genomic offsets
#' \describe{
#'   \item{column names}{Donor population IDs}
#'   \item{row names}{Recipient population IDs}
#' }
#'
#' @usage data(redSprucePops_rawOffset)
"redSprucePops_rawOffset"

#' @title Standardized pairwise genomic offsets between red spruce populations under current and future climates
#'
#' @description Probabilistic re-expression of spatio-temporal offsets between southern Appalachian red spruce populations under current and future climate.
#' Calculated using the \code{\link[offsetEnsembleR]{standardizeOffset}} function and \code{\link[offsetEnsembleR]{redSprucePops_rawOffset}} data.
#' Standardized offsets probabilistically re-express raw offsets as z-scores based on the empirical distribution of contemporary spatial offsets
#' \code{\link[offsetEnsembleR]{redSpruce_ecdfSpatialOffsets}}.
#'
#' @format A matrix of standardized pairwise genomic offsets
#' \describe{
#'   \item{column names}{Donor population IDs (current climate)}
#'   \item{row names}{Recipient population IDs (future climate)}
#' }
#'
#' @usage data(redSprucePops_standardizedOffset)
"redSprucePops_standardizedOffset"

#' @title Pairwise genomic offset between red spruce populations under current and future climates
#'
#' @description Raw spatio-temporal offsets between southern Appalachian red spruce populations under current and future climate.
#' Calculated using the \code{\link[offsetEnsembleR]{spatTempOffset}} function and \code{\link[offsetEnsembleR]{redSprucePops_transClimate}} and
#' \code{\link[offsetEnsembleR]{redSprucePops_transAlteredClimate}} data sets.
#'
#' @format A matrix of pairwise raw genomic offsets
#' \describe{
#'   \item{column names}{Donor population IDs (red spruce populations under current climate)}
#'   \item{row names}{Recipient population IDs (red spruce populations under future climate)}
#' }
#'
#' @usage data(redSprucePops_rawOffset)
"redSprucePops_rawOffset"

#' @title Standardized pairwise genomic offsets between red spruce populations under current and future climates
#'
#' @description Probabilistic re-expression of spatio-temporal offsets between southern Appalachian red spruce populations under current and future climate.
#' Calculated using the \code{\link[offsetEnsembleR]{standardizeOffset}} function and \code{\link[offsetEnsembleR]{redSprucePops_rawOffset}} data.
#' Standardized offsets probabilistically re-express raw offsets as z-scores based on the empirical distribution of contemporary spatial offsets
#' \code{\link[offsetEnsembleR]{redSpruce_ecdfSpatialOffsets}}.
#'
#' @format A matrix of standardized pairwise genomic offsets
#' \describe{
#'   \item{column names}{Donor population IDs (red spruce populations under current climate)}
#'   \item{row names}{Recipient population IDs (red spruce populations under future climate)}
#' }
#'
#' @usage data(redSprucePops_standardizedOffset)
"redSprucePops_standardizedOffset"

#' @title Donor and Recipient Importance of southern Appalachian red spruce populations
#'
#' @description Donor and Recipient Importance of southern Appalachian red spruce populations
#' calculated using the \code{\link[offsetEnsembleR]{donor.recipientImportance}} function and \code{\link[offsetEnsembleR]{redSprucePops_standardizedOffset}} data.
#' The 'not-to-exceed' standardized offset threshold was set to 1 sigma.
#'
#' @format A list of two data frames containing donor and recipient importance. Row names correspond to population IDs.
#' \describe{
#'   \item{donorImportance}{Donor importance}
#'   \item{recipientImportance}{Recipient importance}
#' }
#'
#' @usage data(redSprucePops_DI_RI)
"redSprucePops_DI_RI"

#' @title Genomic offset between red spruce populations under current and Appalachian Blue Ridge Forests under future climate
#'
#' @description Raw spatio-temporal offsets between southern Appalachian red spruce populations under current
#' and Appalachian Blue Ridge Forests under future climate.
#' Calculated using the \code{\link[offsetEnsembleR]{spatTempOffset}} function and \code{\link[offsetEnsembleR]{redSprucePops_transClimate}} and
#' \code{\link[offsetEnsembleR]{blueRidge_transAlteredClimate}} data sets.
#'
#' @format A matrix of pairwise raw genomic offsets
#' \describe{
#'   \item{column names}{Donor population IDs (red spruce populations under current climate)}
#'   \item{row names}{Recipient population IDs (Appalachian Blue Ridge Forest geographic grid cells under future climate)}
#' }
#'
#' @usage data(redSprucePops_blueRidge_rawOffset)
"redSprucePops_blueRidge_rawOffset"

#' @title Standardized pairwise genomic offsets between red spruce populations under current and Appalachian Blue Ridge Forests under future climate
#'
#' @description Probabilistic re-expression of spatio-temporal offsets between southern Appalachian red spruce populations under current
#' and Appalachian Blue Ridge Forests under future climate.
#' Calculated using the \code{\link[offsetEnsembleR]{standardizeOffset}} function and \code{\link[offsetEnsembleR]{redSprucePops_blueRidge_rawOffset}} data.
#' Standardized offsets probabilistically re-express raw offsets as z-scores based on the empirical distribution of contemporary spatial offsets
#' \code{\link[offsetEnsembleR]{redSpruce_ecdfSpatialOffsets}}.
#'
#' @format A matrix of standardized pairwise genomic offsets
#' \describe{
#'   \item{column names}{Donor population IDs (red spruce populations under current climate)}
#'   \item{row names}{Recipient population IDs (Appalachian Blue Ridge Forest geographic grid cells under future climate)}
#' }
#'
#' @usage data(redSprucePops_blueRidge_standardizedOffset)
"redSprucePops_blueRidge_standardizedOffset"

#' @title Donor and Recipient Importance of southern Appalachian red spruce populations
#'
#' @description Donor and Recipient Importance of southern Appalachian red spruce populations (donors) and Appalachian Blue Ridge Forests (recipients)
#' calculated using the \code{\link[offsetEnsembleR]{donor.recipientImportance}} function and \code{\link[offsetEnsembleR]{redSprucePops_blueRidge_standardizedOffset}} data.
#' The 'not-to-exceed' standardized offset threshold was set to 1 sigma.
#'
#' @format A list of two data frames containing donor and recipient importance.
#' Row names correspond to red spruce population IDs (donor importance) and geographic grid cells of the Appalachian Blue Ridge Forest eco-region.
#' The corresponding geographic coordinates can be found in XXX.
#' \describe{
#'   \item{donorImportance}{Donor importance of red spruce populations}
#'   \item{recipientImportance}{Recipient importance of Appalachian Blue Ridge Forest locations}
#' }
#'
#' @usage data(redSprucePops_blueRidge_DI_RI)
"redSprucePops_blueRidge_DI_RI"
