#' reorganize_for_Turner
#'
#' @param SIA_samples data frame with carbon, nitrogen and group
#' @param column_C the name of the column that contains the carbon values
#' @param column_N the name of the column that contains the nitrogen values
#' @param column_group the name of the column that contains the group
#'
#' @return your data frame organized to be used in posterior functions
#' @export
#'
#' @examples SIA_Turner<-organize_for_Turner(SIA_samples=Sula_data,
#' column_C='Carbon',column_N='Nitrogeno',column_group='Species')
organize_for_Turner<-function(SIA_samples=SIA_samples,
                              column_C=column_C,
                              column_N=column_N,
                              column_group=column_group){



  # 1. Data frame ordered with Carbon, Nitrogen, Group
  SIA_Turner<-data.frame(
    column_C=SIA_samples[[column_C]],
    column_N=SIA_samples[[column_N]],
    column_group=SIA_samples[[column_group]])



  return(SIA_Turner)
}
