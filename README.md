
# offsetEnsembleR

<!-- badges: start -->
<!-- badges: end -->

The offsetEnsembleR package provides tools for calculating and standardizing genomic offsets between donor populations under current and recipient locations of population transfers under future environmental conditions. The package also allows to calculate the novel metrics of Donor and Recipient Importance (Lachmuth et al., in review). Potential applications of the offsetEnsembleR pipeline include but are not restricted to: (1) assessing *in situ* global change risks, (2) mapping future habitat suitability while accounting for local adaptations, or (3) selecting donor populations and recipient areas that maximize genomic diversity and minimize maladaptation to future environments in translocation planning.

For the moment, ecological genomic model fitting and the transformation of environmental variables by rescaling them into common units of genomic turnover based on model predictions is not yet part of the package. Instead, data files containing such transformed variables must be created a priori to serve as input for the offsetEnsembleR pipeline. Additional functionality will successively be added.

## Genomic Offsets Calculation

To calculate genomic offsets, Euclidean distances between grid cells in the multidimensional transformed environmental space are computed using the following three types:

1. Contemporary spatial offsets among all geographic grid cells currently occupied by a species in a given study area using transformed current environmental predictors
2. Temporal offsets between current and future environments (i.e., Local Offset) in each grid cell currently occupied by a species
3. Spatio-temporal offsets between currently occupied grid cells (potential donor populations) under current and all potential recipient grid cells under future transformed environmental conditions.

## Standardization of Spatio-Temporal Offsets

To increase the interpretability of (spatio-) temporal offsets, offsetEnsembleR standardizes them using the approach presented by Lachmuth et al. (in review). This is done by probabilistically re-expressing the offsets as z-scores based on the empirical distribution of contemporary spatial offsets. This approach re-scales the (spatio-) temporal offsets relative to the present-day genetic differences between populations across the geographic distribution of the species while also removing confounding effects of dimensionality on Euclidean distance.

It is important to note that both spatial and spatio-temporal offsets need to be calculated based on the same fitted ecological genomic model.

## Calculation of Donor and Recipient Importance

Donor Importance (DI) and Recipient Importance (RI) can be calculated using the standardized spatio-temporal offsets. The calculation involves selecting a “not-to-exceed” standardized genomic offset threshold below which the disruption of genotype-environment associations is considered analogous to the distribution of present-day spatial offsets across the geographic range of the species. 

Application of the offset threshold yields a population transferability matrix of potential donor and recipient locations classifying matches as analogous, (i.e., below threshold, coded as 1) or non-analogous (i.e., above threshold, coded as 0). Donor Importance (DI) for each donor cell is calculated as the percentage of recipient cells in the study area with a standardized offset below the threshold z-score, whereas Recipient Importance (RI) of each potential recipient cell represents the percentage of donor cells with a standardized offset below the threshold z-score.

## Installation

You can install the development version of offsetEnsembleR from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("SusanneLachmuth/offsetEnsembleR")
```

## Example

Examples are provided in the documentation of the functions included in the package.



## References

- Lachmuth, S., Capblancq, T., Prakash, A., Keller, S.R., Fitzpatrick, M.C., in review. Novel genomic offset metrics integrate local adaptation into habitat suitability forecasts and inform assisted migration.
