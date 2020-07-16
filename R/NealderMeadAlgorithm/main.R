# Function
ObjFun <- function(x){
  out <- x[1]^2 - 4*x[1] + x[2]^2 - x[2] - x[1]*x[2]
  return(out)
}

# Initial parameters setup
x0 <- c(0,0)
iter_max <- 200

# Algorithm
nd <- NealderMead(ObjFun, x0, int_step = 0.9, expan = 3,  max_iter =iter_max)

## Plotting part
nGrid <- 100
x_seq <- seq(-1, 5, length.out = nGrid)
z_matrix <- matrix(NA, nrow = nGrid, ncol = nGrid)
for (i in 1 : nGrid) {
  for (j in 1 : nGrid) {
    z_matrix[i,j] <- ObjFun(c(x_seq[i], x_seq[j]))
  }
}
# plot function
contour(x_seq, x_seq, z_matrix)

# Animate search Nealder-Mead
for (i in 1 : length(nd$simp_hist[,1])) {
  lines(x=nd$simp_hist[c(seq(3 * i - 2, i *3 ), 3 * i -2),1], y=nd$simp_hist[c(seq(3 * i - 2, i *3 ), 3 * i -2),2], col = "red")
  Sys.sleep(1)
}
