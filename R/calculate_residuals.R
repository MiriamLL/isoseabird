#' A function to calculate the residuals from the models
#'
#' @param SIA_matrix Contains the carbon and the nitrogen values
#' @param SIA_group Contains the group values
#'
#' @return Returns two columns, one for residuals from carbon and other column for nitrogen
#' @export
#'
#' @examples SIA_residuals<-calculate_residuals(SIA_matrix=SIA_matrix,SIA_group = SIA_group)
calculate_residuals<-function(SIA_matrix=SIA_matrix,
                              SIA_group=SIA_group){


  #1. Obtains information from the data frame to calculate number of groups and possible interactions.
  Number_groups<-length(levels(SIA_group))
  Possible_comparisons<-(Number_groups^2-Number_groups)/2

  #2. Linear model for estimating group means
  Linear_model<-stats::lm(SIA_matrix~SIA_group,x=T,model=T)

  #3. Calculate residuals of groups from group means
  Residuals_groups<-stats::resid(Linear_model)

  #4. Calculate predicted values
  Predicted_values<-stats::predict(Linear_model)

  #5. This is the model reduced by the group factor: only estimates an overall mean
  Reduced_model<-stats::lm(SIA_matrix~1) #

  return(Residuals_groups=Residuals_groups)
}
