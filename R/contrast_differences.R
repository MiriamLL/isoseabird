#' A function to contrast mean differences
#'
#' @param SIA_tabledispersion A table with mean dispersion values
#'
#' @return A data frame with dispersion differences using different methods
#' @export
#'
#' @examples SIA_dispersiondif<-contrast_differences(SIA_tabledispersion = SIA_tabledispersion)
contrast_differences<-function(SIA_tabledispersion=SIA_tabledispersion){

  # Contrast mean differences
  ds.dif<-function(A){
    n.m<-NULL # n.m stands for "new" matrix
    c<-ncol(A)
    for(i in 1:c){
      temp<-as.matrix(A[,i])
      dis<-as.vector(stats::dist(temp))
      n.m<-cbind(n.m,dis)
    }
    n.g<-list(mdc=n.m[,1],mnn=n.m[,2],ecc=n.m[,3])

    n.g
  }

  SIA_dispersiondif<-ds.dif(SIA_tabledispersion)
  return(SIA_dispersiondif)
}
