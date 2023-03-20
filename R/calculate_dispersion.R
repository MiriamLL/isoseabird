#' A function to calculate dispersion
#'
#' @param SIA_residuals is the residuals from carbon and nitrogen
#' @param SIA_group is the groups in the model (as factor)
#'
#' @return the dispersion calculations
#' @export
#'
#' @examples SIA_dispersion<-calculate_dispersion(SIA_residuals = SIA_residuals,SIA_group=SIA_group)
calculate_dispersion<-function(SIA_residuals=SIA_residuals,
                               SIA_group=SIA_group){

  #1. Load function ds.prep
  ds.prep<-function(A,g){
    rownames(A)<-g
    n.m<-NULL #n.m stands for "new" matrix
    n.t<-length(g) #the 'total' sample size
    gp<-length(levels(g)) #the number of groups
    gn<-tapply(g,g,length) #the separate group sample sizes
    nmax<-max(gn) #the maximum group size

    s<-1  # the start point
    n<-gn[1]  # the sample size of the first group

    B<-NULL # This simple step orders the data by groups, irrespective of the original order
    for(i in 1:n.t){
      temp<-as.matrix(A[which(g==levels(g)[i]),])
      B<-rbind(B,temp)
    }

    for(i in 1:gp){# Create objects 'res.gp.1', 'res.gp.2', ... 'res.gp.n'

      d<-nmax-gn[i]
      blank<-as.matrix(array(NA,2*d));dim(blank)<-c(d,2)
      nam <- paste("res.gp",i, sep=".")
      temp<-B[s:n,1:2]
      temp<-rbind(temp,blank)  # this assures equal sample sizes for the matrices
      assign(nam,temp) # note: the matrix has correct dimensions
      temp<-array(temp) # now the matrix is a vector
      n.m<-c(n.m,temp) # now there is a matrix of row vectors

      s<-s+gn[i]
      n<-n+gn[i+1]

    }

    C<-array(n.m,dim=c(nmax,2,gp)) # the vectors are reassembled into submatrices of a 3-d matrix
  }

  #2. Use function
  SIA_dispersion<-ds.prep(SIA_residuals,SIA_group)
  return(SIA_dispersion)
}
