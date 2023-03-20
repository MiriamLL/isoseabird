#' Calculate hotellings T2 using Turner et al 2020 script
#' 'Hotellings reveleaded that Euclidian distance between centroids differed significantly from zero for contrast between guilds'
#' @param SIA_means the means from your calculations
#' @param SIA_group group levels as factors
#' @param SIA_matrix a matrix with carbon and nitrogen values
#'
#' @return values hotellings
#' @export
#'
#' @examples SIA_hotellings<-calculate_hotellings(SIA_means=calculate_means(SIA_matrix,SIA_group),
#' SIA_group=SIA_group,
#' SIA_matrix=SIA_matrix)
calculate_hotellings<-function(SIA_means=SIA_means,
                               SIA_group=SIA_group,
                               SIA_matrix=SIA_matrix){

  # HOTELLING'S T2
  #1. vector for difference between means
  gp.m.dif<-SIA_means[1,]-SIA_means[2,]

  #2. Group Sizes
  gn<-tapply(SIA_group,SIA_group,length)

  Linear_model<-stats::lm(SIA_matrix~SIA_group,x=T,model=T)

  #3. Obtain model parameters
  e<-stats::resid(Linear_model)
  E<-t(e)%*%e
  n<-nrow(e)
  k<-Linear_model$rank
  V<-(1/(n-k))*E # This is the pooled within-group vcv
  d<-gp.m.dif; dim(d)<-c(1,length(d))
  D<-d%*%solve(V)%*%t(d) # Squared Mahalanobis Distance
  H.T2<-(gn[1]*gn[2])/(gn[1]+gn[2])*D # Hotelling T2
  F<-(gn[1]+gn[2]-2-1)/((gn[1]+gn[2])*2)*H.T2 # Convert to an F value
  P<-stats::df(F,2,(gn[1]+gn[2]-2-1)) # P-value

  P_value<-round(P,digits=6)
  return(P_value)
}
