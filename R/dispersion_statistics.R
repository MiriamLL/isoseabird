#' A function to calculate dispersion statistics
#'
#' @param SIA_dispersion Are values calculated with the function calculate_dispersion
#' @param SIA_group is the group levels as factor
#'
#' @return returns a table with values
#' @export
#'
#' @examples SIA_tabledispersion<-dispersion_statistics(SIA_dispersion=SIA_dispersion,SIA_group=SIA_group)
dispersion_statistics<-function(SIA_dispersion=SIA_dispersion,
                                SIA_group=SIA_group){

  # 0. Arguments
  gp<-length(levels(SIA_group))

  # 1. Load functions
  ### mdc: Mean distance to Centroid
  mdc<-function(w){ # w will be the 3-d matrix from above
    d.sum<-0
    for(i in 1:(nrow(w))){
      v<-w[i,]
      dim(v)<-c(1,length(v))
      d<-sqrt(v%*%t(v)) # this is the Euclidean distance of the residual to centroid
      d.sum<-d.sum+d # this adds that distance to the progressive sum
    }
    m<-d.sum/nrow(w) # this calculates the mean of the sum of all distances
  }


  ### mnm: Mean nearest neighbor
  mnn<-function(w){
    d<-as.matrix(stats::dist(w)) # first create distance matrices
    n<-ncol(d) # each column provides one value; thus n is the # of columns
    d.sum<-0
    for(i in 1:n){
      y<-d[,i]
      # need to subtract the 0 from the column, which is the distance of
      # something to itself
      y<-y[-i]
      m<-min(y) # the minimum distance is the nearest neighbor
      d.sum<-d.sum+m # this adds that distance to the progressive sum
    }
    mnn<-d.sum/n # this calculates the mean of the sum of all nearest distances
  }


  ## ecc: Eccentricity
  ecc<-function(w){
    v<-stats::var(w)
    p<-eigen(v)
    ev<-p$values
    ecc<-1-(ev[2]/ev[1])
  }


  # 2. Main functions
  disp.stat<-function(w){
    result<-NULL
    rn<-NULL # rn = row name
    for(j in 1:gp){
      x<-w[,,j]
      x<-stats::na.omit(x)
      m<-mdc(x) # Note that this function calls the functions defined above
      n<-mnn(x)
      e<-ecc(x)
      rn<-c(rn,paste("Group",j,sep=".")) # names the rows
      result<-rbind(result,c(m,n,e))
      rownames(result)<-rn
      colnames(result)<-c("mdc","mnn","ecc") # names the columns

    }
    result
  }

  # 3. Run function
  SIA_tabledispersion<-disp.stat(SIA_dispersion)
  return(SIA_tabledispersion)
}
