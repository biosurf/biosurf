outersect <- function(x) {
  ir <- setdiff(reduce(unlist(x)), Reduce(intersect, x))
  return(reduce(ir))
}