#' A function for a permutation procedure
#'
#' @param SIA_matrix A matrix with carbon and nitrogen values
#' @param SIA_group Group levels as factors
#' @param SIA_dispersiondif Calculation from dispersions
#' @param permutation_runs Number of permutations
#'
#' @return results from permutation
#' @export
#'
#' @examples SIA_permutation<-run_permutation(SIA_matrix=SIA_matrix, SIA_group=SIA_group,
#' SIA_dispersiondif = SIA_dispersiondif,permutation_runs=999)
run_permutation<-function(SIA_matrix=SIA_matrix,
                          SIA_group=SIA_group,
                          SIA_dispersiondif=SIA_dispersiondif,
                          permutation_runs=permutation_runs){
  # 1. Arguments
  Y<-SIA_matrix
  gp<-length(levels(SIA_group))
  disp.dif<-SIA_dispersiondif

  # 2. Prior functions

  ## 2.1 group.means
  group.means<-function(A,g){# A = data, g = list of group ids
    rownames(A)<-g
    l<-stats::lm(A~g,x=T,model=T)
    ls<-data.frame(g=levels(g))
    ls[]<-lapply(ls,factor)
    m<-stats::predict(l,ls)
    m
  }

  ## 2.2. ds.prep
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
      assign(nam,temp) # note: the matix has correct dimensions
      temp<-array(temp) # now the matrix is a vector
      n.m<-c(n.m,temp) # now there is a matrix of row vectors

      s<-s+gn[i]
      n<-n+gn[i+1]

    }

    C<-array(n.m,dim=c(nmax,2,gp)) # the vectors are reassembled into submatrices of a 3-d matrix
  }


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

  ### ecc: Eccentricity
  ecc<-function(w){
    v<-stats::var(w)
    p<-eigen(v)
    ev<-p$values
    ecc<-1-(ev[2]/ev[1])
  }

  # dis.stat
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

  ds.dif<-function(A){
    n.m<-NULL # n.m stands for "new" matrix
    c<-ncol(A)
    for(i in 1:c){
      temp<-as.matrix(A[,i])
      dis<-as.vector(stats::dist(temp))
      n.m<-cbind(n.m,dis)
    }
    n.g<-list(mdc=n.m[,1],mnn=n.m[,2],ecc=n.m[,3])

    n.g
  }

  # 3. Permute function
  permute<-function(x,x2,y,g,p){
    p.table<-NULL

    yhat<-stats::predict(x)
    res<-stats::resid(x)
    line<-nrow(res) # this defines the number of permutable objects
    yhat.2<-stats::predict(x2)
    res.2<-stats::resid(x2)

    mean.dif<-as.vector(stats::dist(as.matrix(group.means(Y,g))))


    for(i in 1:p){

      #For dispersion tests

      line.rand<-sample(line,replace=FALSE) # This creates a line from 1 to the number
      # of permutable objects, then randomizes the order
      res.temp<-cbind(line.rand,res) # attaches the random order to the ordered matrix
      z<-(order(line.rand)) # randomizes matrix as it reorders line
      res.temp2<-as.matrix(res.temp[z,])# removes randomized line
      res.p<-res.temp2[,-1] # Rows of residuals are now randomized
      y.rand<-yhat+res.p # random values created

      # The resampling procedure above is the same as randomizing original values
      # (Since the reduced model only contains the overall mean)
      # But using residuals makes it applicable to multi-factor models

      lm.r<-stats::lm(y.rand~g,x=T,model=T) # new linear model
      r<-stats::resid(lm.r)
      yhat<-stats::predict(lm.r)
      ex1.r<-ds.prep(r,g) #thanks to the functions, prep takes one step
      ex.r.ds<-disp.stat(ex1.r) # thanks to the function, dispersion stats require one step
      disp.dif.r<-ds.dif(ex.r.ds) # thanks to function, contrasts require one step


      # For means tests

      # uses different linear model
      # the null hypothesis that means are equal
      # means that an intercept model (i.e., defines only the overall mean)
      # is as viable as a group means model.
      # Thus, residuals are calculated from the intercept model (see above)
      # and random means are created despite no mean differences define by the model
      # this creates random distibutions of outcomes under the null hypothesis

      res.2.temp<-cbind(line.rand,res.2)
      z<-(order(line.rand))
      res.2.temp2<-as.matrix(res.2.temp[z,])
      res.2.p<-res.temp2[,-1] # Rows of residuals are now randomized
      y.rand.2<-yhat.2+res.2.p


      gm.r<-group.means(y.rand.2,g)
      md.r<-as.vector(stats::dist(as.matrix(gm.r)))

      result<-c(i,md.r,disp.dif.r$mdc,disp.dif.r$mnn,disp.dif.r$ecc) # bind all results together
      p.table<-rbind(p.table,result) # add them to a table, row by row

    }

    head<-NULL # create a header
    line1<-as.vector(c(0,mean.dif,disp.dif$mdc,disp.dif$mnn,disp.dif$ecc))

    # The following is a bunch of code simply for generating column names in the output

    cn<-length(mean.dif) # cn = column name

    test.list<-NULL
    if (cn>1) for(i in 1:cn){
      l1<-rep(i,cn)
      l2<-array(1:cn)
      l12<-cbind(l1,l2)
      test.list<-rbind(test.list,l12)
    }

    test.list2<-NULL
    if (cn>1) for(j in 1:nrow(test.list)){
      t<-test.list[j,]
      if(t[2]>t[1]) test.list2<-rbind(test.list2,t)
    }

    test.list3<-NULL
    if (cn>1) for(k in 1:nrow(test.list2)){
      t<-test.list2[k,]
      lab<-paste(t[1],t[2],sep="--")
      test.list3<-rbind(test.list3,lab)}

    if (cn==1) test.list3<-c("1--2")

    lab2<-c(rep("MD",cn),rep("MDC",cn),rep("MNN",cn),rep("ECC",cn))
    test.list4<-paste(lab2,test.list3,sep=".")

    head<-c("iteration",test.list4)
    p.table<-rbind(head,line1,p.table)

  }

  SIA_lm_groups<-stats::lm(SIA_matrix~SIA_group,x=T,model=T)
  SIA_lm_residuals<-stats::lm(SIA_matrix~1) #

  SIA_permutation<-permute(SIA_lm_groups,
                           SIA_lm_residuals,
                           SIA_matrix,
                           SIA_group,
                           permutation_runs) #run 999 times
  return(SIA_permutation)
}
