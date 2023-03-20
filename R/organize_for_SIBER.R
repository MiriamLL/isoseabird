#' A function to organize columns as requiered by SIBER
#'
#' @param SIA_samples A data frame with the carbon, nitrogen and group values
#' @param column_N the name of the column that contains the nitrogen values
#' @param column_C the name of the column that contains the carbon values
#' @param column_group the name of the column that contains the groups
#'
#' @return a new data frame organized as requiered by SIBER
#' @export
#'
#' @examples SIBER_SIA<-organize_for_SIBER(SIA_samples=Sula_data,
#' column_C='Carbon',column_N='Nitrogeno',column_group='Species')
organize_for_SIBER<-function(SIA_samples=SIA_samples,
                             column_N=column_N,
                             column_C=column_C,
                             column_group=column_group){
  SIA_SIBER<-SIA_samples
  SIA_SIBER$community<-c('1')
  SIA_SIBER$C<-SIA_SIBER[[column_C]]
  SIA_SIBER$N<-SIA_SIBER[[column_N]]
  SIA_SIBER$group<-SIA_SIBER[[column_group]]


  SIA_SIBER<-SIA_SIBER[,c('C','N','group','community')]

  return(SIA_SIBER)
}
