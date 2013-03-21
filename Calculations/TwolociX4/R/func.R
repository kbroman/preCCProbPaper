pullprob <-
function(gen=4, prob=res1)
  t(sapply(prob, function(a,b) a[b,], gen))

calcpk <-
function(r, start=pi0, tmfunc=femaleAAABtm, ngen=4)
{
  res <- matrix(ncol=nrow(start), nrow=length(r))
  for(i in seq(along=r)) {
    A <- tmfunc(r[i])
    cur <- start
    for(k in 1:ngen)
       cur <- cur %*% A
    res[i,] <- cur[,1]
  }
  res
}
