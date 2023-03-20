#' A function to add theme for SIA ggplot2
#'
#' @param SIA_plot SIA plot created in ggplot2 it will show as a list
#'
#' @return a ggplot with a specific theme
#' @export
#'
#' @examples SIA_plot_theme<-adapt_theme(SIA_plot=SIA_plot)
adapt_theme<-function(SIA_plot=SIA_plot){
  SIA_plot_theme<-SIA_plot +
    ggplot2::theme_bw()+
    ggplot2::theme(plot.title = ggplot2::element_text(size = 12, face = "bold"),
                   legend.position = 'none',
                   text = ggplot2::element_text(size=14),
                   axis.title.x = ggplot2::element_text(size = 16, hjust = 0.54, vjust = 0),
                   axis.title.y = ggplot2::element_text(size = 16, angle = 90,  vjust = 0.10),
                   panel.grid.major = ggplot2::element_blank(),
                   panel.grid.minor = ggplot2::element_blank(),
                   axis.text.x = ggplot2::element_text(size=12),
                   axis.text.y=ggplot2::element_text(size=12))
  return(SIA_plot_theme)
}
