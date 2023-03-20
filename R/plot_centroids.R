#' A function to plot the stable isotopes values and the centroid locations
#'
#' @param SIA_samples a data frame with your stable isotope data
#' @param column_C the name of the column that contains the carbon values
#' @param column_N the name of the column that contains the nitrogen values
#' @param column_group the name of the column with the groups to compare
#' @param group1 the name (in characters) of the first group
#' @param group2 the name (in characters) of the second group
#'
#' @return prints a plot in base R
#' @export
#'
#' @examples plot_centroids(SIA_samples=Sula_data, column_C='Carbon', column_N='Nitrogeno',
#' column_group='Species', group1="SulaSula", group2="Dactylatra")
plot_centroids<-function(SIA_samples=SIA_samples,
                         column_C=column_C,
                         column_N=column_N,
                         column_group=column_group,
                         group1=group1,
                         group2=group2){

  SIA_Turner<-data.frame(
    column_C=SIA_samples[[column_C]],
    column_N=SIA_samples[[column_N]],
    column_group=SIA_samples[[column_group]])

  #1. Define groups
  Trophic_group1<-SIA_samples[SIA_samples[,3]==group1,1:2]
  Trophic_group2<-SIA_samples[SIA_samples[,3]==group2,1:2]
  All_points<-rbind(Trophic_group1,Trophic_group2)

  #2. Plot per group
  plot(All_points,type='n',asp=1,
       xlab=expression(delta^13~C),
       ylab=expression(delta^15~N),
       cex.lab=1.7,cex.axis=1.7)
  graphics::points(Trophic_group1, pch=21,bg='green')
  graphics::points(Trophic_group2, pch=21,bg='red')

  # 3. Add centroid
  Mean_group1<-colMeans(Trophic_group1)
  Mean_group2<-colMeans(Trophic_group2)

  graphics::points(Mean_group1[1],Mean_group1[2],
         pch=21,bg='blue',cex=1.7,lwd=2.5)
  graphics::points(Mean_group2[1],Mean_group2[2],
         pch=21,bg='yellow',cex=1.7,lwd=2.5)
}
