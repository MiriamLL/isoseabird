#' A function to plot ellipses using ggplot2
#'
#' @param SIA_samples A data frame with a column for carbon, nitrogen and group
#' @param column_C the name of the column carbon
#' @param column_N the name of the column nitrogen
#' @param column_group the name of the column containing the groups
#'
#' @return returns a ggplot2 that can be further modified, plots 50 and 95 ellipses
#' @export
#'
#' @examples SIA_plot<-ggplot_ellipse(SIA_samples<-Sula_data, column_C<-'Carbon',
#' column_N<-'Nitrogeno', column_group<-'Species')
ggplot_ellipse<-function(SIA_samples=SIA_samples,
                         column_C=column_C,
                         column_N=column_N,
                         column_group=column_group){

  SIA_organized<-data.frame(
    column_C=SIA_samples[[column_C]],
    column_N=SIA_samples[[column_N]],
    column_group=SIA_samples[[column_group]])

  SIA_plot<-ggplot2::ggplot(data=SIA_organized,
                            ggplot2::aes(x=column_C,
                                         y=column_N))+
    ggplot2::geom_point(
      ggplot2::aes(color=column_group),size=1.5,alpha=0.5)+

    ggplot2::stat_ellipse(
      ggplot2::aes(group = column_group,color = column_group),
      level = 0.95,type = "norm",size=0.8)+

    ggplot2::stat_ellipse(
      ggplot2::aes(group = column_group,color = column_group),
      level = 0.50,type = "norm",size=0.8)
  return(SIA_plot)
}
