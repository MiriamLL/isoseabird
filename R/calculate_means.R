#' A function to calculate group means
#'
#' @param SIA_matrix A matrix with carbon and nitrogen values
#' @param SIA_group Groups as factors
#'
#' @return Means per group
#' @export
#'
#' @examples SIA_means<-calculate_means(SIA_matrix,SIA_group)
calculate_means<-function(SIA_matrix=SIA_matrix,
                          SIA_group=SIA_group){

  group.means<-function(A,g){# A = data, g = list of group ids
    rownames(A)<-g
    l<-stats::lm(A~g,x=T,model=T)
    ls<-data.frame(g=levels(g))
    ls[]<-lapply(ls,factor)
    m<-stats::predict(l,ls)
    m
  }

  SIA_means<-group.means(SIA_matrix,SIA_group)
  return(SIA_means)
}
