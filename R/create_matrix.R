#' Create matrix to run functions from Turner et al. 2010
#'
#' @param SIA_Turner A data frame containing the carbon, nitrogen and group values
#'
#' @return SIA_matrix
#' @export
#'
#' @examples SIA_matrix<-create_matrix(SIA_Turner = SIA_Turner)
create_matrix<-function(SIA_Turner=SIA_Turner){

  # 1. Convert to matrix
  SIA_matrix<-as.matrix(SIA_Turner[,1:2])

  #2. Designate group
  SIA_group<-as.factor(SIA_Turner[,3])
  rownames(SIA_matrix)<-SIA_group

  return(SIA_matrix)
}
