#' A function to convert my data frame into siber object
#'
#' @param SIBER_SIA the organized data frame is not going to be converted to siber object for later uses
#'
#' @return the siber object as requiered by SIBER
#' @export
#'
#' @examples SIBER_object<-convert_object(SIBER_SIA=SIBER_SIA)
convert_object<-function(SIBER_SIA=SIBER_SIA){

  #SiberObject
  colnames(SIBER_SIA)<-c('iso1','iso2','group','community')
  SIBER_object<-SIBER::createSiberObject(SIBER_SIA)
  return(SIBER_object)
}
