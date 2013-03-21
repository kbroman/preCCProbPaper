
stepback <-
function(patterns)
{
  nchar <- nchar(patterns)
  lastchar <- substr(patterns, nchar, nchar)
  newpat <- NULL
  if(any(lastchar=="M")) {
    newpat <- c(newpat, paste(patterns[lastchar=="M"], "F", sep=""))
  }
  if(any(lastchar=="F")) {
    newpat <- c(newpat, 
                paste(patterns[lastchar=="F"], "F", sep=""),
                paste(patterns[lastchar=="F"], "M", sep=""))
  }
  newpat
}

genpat <-
function(start="F", nstep=1)
{
  if(nstep==0) return(start)
  patterns <- start
  for(i in 1:nstep) 
    patterns <- stepback(patterns)
  patterns
}

countFM <-
function(patterns)
{
  nchar <- nchar(patterns)
  lastchar <- substr(patterns, nchar, nchar)
  rest <- substr(patterns, 1, nchar-1)
  nf <- sapply(strsplit(rest, ""), function(a) sum(a=="F"))
  if(any(lastchar=="F")) {
    nf[lastchar=="F"] <- nf[lastchar=="F"]+1
    nf <- c(nf,nf[lastchar=="F"])
  }
  table(nf)
}

val <-
function(start="F", nstep=5, r=0.05)
{
  tab <- countFM(genpat(start, nstep))
  sum(tab * ((1-r)/2)^as.numeric(names(tab)))
}
  
