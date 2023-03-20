#' A function to calculate the proportion of overlap between areas
#'
#' @param area_overlap is the overlap that you want to compare, it needs to have three columns
#'
#' @return the proportion of overlap in a two digits decimals
#' @export
#'
#' @examples prop_overlap_95<-proportion_overlap(area_overlap = SIBER_overlap_95)
proportion_overlap<-function(area_overlap=area_overlap){

  prop_over<-area_overlap[3] / (area_overlap[2] +
                                  area_overlap[1] -
                                  area_overlap[3])
  prop_over<-round(prop_over,digits=2)
  return(prop_over)
}
