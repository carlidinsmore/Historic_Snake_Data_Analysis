##############################
### Von Bertalanffy Growth ###
##############################

setwd("C:/Users/djm516.ACCESS/Dropbox/CA_Snake")
dat<-read.csv("VBG_Papoose_TimeInterval.csv")

str(dat)
library(R2jags)

# load data
data <- list(Lr=dat$SVL.1, Lm = dat$SVL, dT = dat$dT, n = dim(dat)[1])

# Initial values
inits <- function(){list(L.inf = rnorm(1,0,0.001), K = rnorm(1,1,0.001))}



# Parameters monitored
params1 <- c("L.inf", "K", "sigma.Lr","tau.Lr")


# MCMC settings
ni <- 10000
nt <- 3
nb <- 1000
nc <- 3


############################################
###### DO analysis in JAGS and compare times
start.time = Sys.time()         # Set timer

out <- jags(data = data, inits = inits, parameters.to.save = params1, 
            model.file = "modelBasicVBG.txt", n.chains = nc, n.thin = nt, n.iter = ni, 
            n.burnin = nb)

end.time = Sys.time()
elapsed.time = round(difftime(end.time, start.time, units='mins'), dig = 2)
cat('Posterior computed in ', elapsed.time, ' minutes\n\n', sep='') 
# Calculate computation time


# Summarize the result
print(out, digits = 3)

