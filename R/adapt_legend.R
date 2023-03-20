#' A function to add text for labels inside the plot
#'
#' @param SIA_plot is a ggplot2 with the SIA ellipses
#' @param xlabel_adjust is a number on the x axis
#' @param ylabel_adjust is a number on the y axis
#' @param label1 is the text that will be displayed upper
#' @param label2 is the text that will be displayed under
#' @param color1 is the color of the circle displayed upper
#' @param color2 is the color of the circle displayed under
#'
#' @return a ggplot with text as legend
#' @export
#'
#' @examples SIA_plot_legend<-adapt_legend(SIA_plot=SIA_plot,
#' xlabel_adjust=-19.9,ylabel_adjust=17.9,label1='Masked booby',label2='Red-footed booby',
#' color1='#233d4d',color2='#2a9d8f')
adapt_legend<-function(SIA_plot=SIA_plot,
                       xlabel_adjust=xlabel_adjust,
                       ylabel_adjust=ylabel_adjust,
                       label1=label1,
                       label2=label2,
                       color1=color1,
                       color2=color2){

  SIA_plot_legend<-SIA_plot+

    ggplot2::annotate(geom = "point",
                      x = xlabel_adjust,
                      y = ylabel_adjust-0.3,
                      fill= color1,
                      color=color1,
                      shape = 21,
                      size = 3)+

    ggplot2::annotate(geom="text",
                      x= xlabel_adjust+0.2,
                      y = ylabel_adjust-0.3,
                      label=label1,
                      color="black",
                      size = 3.5,
                      hjust = 0)+


    ggplot2::annotate(geom = "point",
                      x = xlabel_adjust,
                      y = ylabel_adjust,
                      fill=color2,
                      color=color2,
                      shape = 21,
                      size = 3)+

    ggplot2::annotate(geom="text",
                      x= xlabel_adjust+0.2,
                      y = ylabel_adjust,
                      label=label2,
                      color="black",
                      size = 3.5,
                      hjust = 0)

  return(SIA_plot_legend)
}
