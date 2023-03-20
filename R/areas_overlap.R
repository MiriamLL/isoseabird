#' A function to directly calculate areas of overlap between ellipses using functions from the package SIBER
#'
#' @param SIBER_object A SIBER object
#' @param group1 the name of the group 1
#' @param group2 the name of the group 2
#' @param overlap_value the overlap you want to calculate, e.g. 0.50 50, 0.95 95
#'
#' @return returns three values, 1. area overlap of group 1, 2. area of overlap of group 2 and 3. area of overlap between the two
#' @export
#'
#' @examples SIBER_overlap_50<-areas_overlap(SIBER_object = SIBER_object,
#' group1='SulaSula',group2='Dactylatra',overlap_value = 0.50)
areas_overlap<-function(SIBER_object=SIBER_object,
                        group1=group1,
                        group2=group2,
                        overlap_value=overlap_value){

  # 1. rename exactly as in the siber object
  Ellipse_group1<-paste0("1.",group1)
  Ellipse_group2<-paste0("1.",group2)

  # 2. calculate overlap
  calculated_overlap <- SIBER::maxLikOverlap(Ellipse_group1,
                                             Ellipse_group2,
                                             SIBER_object,
                                             p.interval = overlap_value,
                                             n = 100)
  ellipses_overlap<-round(calculated_overlap, digits=2)

  return(ellipses_overlap)}
