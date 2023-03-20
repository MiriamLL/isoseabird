#' A function to change the color of the ellipses in ggplot
#'
#' @param SIA_plot a ggplot (will show as a list of 9)
#' @param column_group the name of the column group
#' @param color1 the color for group 1
#' @param color2 the color for group 2
#'
#' @return a ggplot with ellipses in different colors
#' @export
#'
#' @examples SIA_plot_colors<-adapt_colors(SIA_plot=SIA_plot,
#' color1='#233d4d',color2='#2a9d8f',column_group='Species')
adapt_colors<-function(SIA_plot=SIA_plot,
                       color1=color1,
                       color2=color2){

  SIA_plot_colors<-SIA_plot +
    ggplot2::scale_color_manual(values = c(color1,color2))


  return(SIA_plot_colors)
}
