#' Calculate the P-value by measuring the rank of the first value in the distribution of values in the same column.
#'
#' @param SIA_permutation results from the permutation producedure
#'
#' @return p values
#' @export
#'
#' @examples SIA_pvalue<-calculate_pvalues(SIA_permutation=SIA_permutation)
calculate_pvalues<-function(SIA_permutation=SIA_permutation){


  # Obtain p-values by comparing groups using the different methods
  p_table<-SIA_permutation

  h<-p_table[1,];h<-h[-1]
  t<-p_table[-1,];t<-t[,-1]
  f<-function(t){
    r<-rank(t)
    p<-r[1]
    c<-length(t)
    pv<-(c-p+1)/c}

  p_value<-apply(t,2,f)
  names(p_value)<-h

  return(p_value)
}
