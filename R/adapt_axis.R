#' A function to define axis in a ggplot of stable istopes
#'
#' @param SIA_plot the basic plot
#' @param C_breaks the breaks for the axis containing carbon values
#' @param C_limits the limits for the axis containing carbon values
#' @param N_breaks the breaks for the axis contianing nitrogen values
#' @param N_limits the limits for the axis containing nitrogen values
#'
#' @return a ggplot2 with defined axis x and y
#' @export
#'
#' @examples SIA_plot_axis<-adapt_axis(SIA_plot=SIA_plot,
#' C_breaks=c(-20,-19,-18,-17,-16,-15,-14),C_limits=c(-20,-14),
#' N_breaks=c(14,15,16,17,18),N_limits=c(13.5,18.1))
adapt_axis<-function(SIA_plot=SIA_plot,
                     C_breaks=C_breaks,C_limits=C_limits,
                     N_breaks=N_breaks,N_limits=N_limits
){

  SIA_plot_limits<-SIA_plot +

    ggplot2::labs(x=expression(atop(bold(paste(delta^{13}, "C (\u2030)")))))+
    ggplot2::labs(y=expression(atop(bold(paste(delta^{15}, "N (\u2030)")))))+

    ggplot2::scale_x_continuous(breaks=C_breaks, limits=C_limits)+
    ggplot2::scale_y_continuous(breaks=N_breaks, limits=N_limits)

  return(SIA_plot_limits)
}
