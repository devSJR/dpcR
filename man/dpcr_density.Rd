\name{dpcr_density}
\alias{dpcr_density}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Calculate density of digital PCR
}
\description{
A function which calculates and plots the density of the number of positive molecules or the average 
number of molecules per partition. Can be used for both array digital PCR and droplet digital PCR.
}
\usage{
dpcr_density(k, n, average = FALSE, methods = "wilson", conf.level = 0.95, 
             plot = TRUE)
}
\arguments{
  \item{k}{
Total number of positive molecules.
}
  \item{n}{
Total number of partitions.
}
  \item{average}{
If \code{TRUE}, calculates density of the average number of molecules per partition. If 
\code{FALSE}, instead performs calculations for the total number of positive molecules.
}
  \item{methods}{
Which method of calculating confidence interval should be used. Possible values are: 
\code{"wilson"}, \code{"agresti-coull"}, \code{"exact"}, \code{"prop.test"}, \code{"profile"}, 
\code{"lrt"}, \code{"asymptotic"}, \code{"bayes"},
\code{"cloglog"}, \code{"logit"}, \code{"probit"}. Default value is \code{"wilson"}. See Details.
}
  \item{conf.level}{
The level of confidence to be used in the confidence interval. Values from 0 to 1 and -1 to 0 are 
acceptable.
}
  \item{plot}{
    If \code{TRUE}, plots density plot.
    }
}
\details{
Confidence interval is calculated by \link[binom]{binom.confint}.
}
\value{
A data frame with one row containing bounds of the confidence intervals and a name of the method
used to calculate them.
}
\references{
  Brown, Lawrence D., T. Tony Cai, and Anirban DasGupta. \emph{Confidence Intervals for a Binomial 
							      Proportion and Asymptotic Expansions.} 
  The Annals of Statistics 30, no. 1 (February 2002): 160--201.
  }
\author{
Michal Burdukiewicz, Stefan Roediger.
}

\note{
The browser-based graphical user interface for this function is accessible as \link{dpcr_density_gui}.
}

\seealso{
\link[binom]{binom.confint}, \link{dpcr_density_gui}.
}
\examples{
# Calculate the average number of molecules per partition and show the area
# of the confidence interval (left plot) and the area within the confidence 
# interval
par(mfrow = c(1,2))
dpcr_density(k = 25, n = 55, average = TRUE, methods = "wilson", conf.level = 0.9)
dpcr_density(k = 25, n = 55, average = TRUE, methods = "wilson", conf.level = -0.9)

# By setting average to FALSE the total number of positive molecules is calculated
par(mfrow = c(1,1))
dpcr_density(k = 25, n = 55, average = FALSE, methods = "wilson", conf.level = 0.95)

# Example of an artificial chamber dPCR experiment using the reps384 data set from
# qpcR. The function cpD2limiter is used to calculate the cpD2 value and converts 
# all values between a defined range to 1 and the remaining to 0.
cpD2limiter <- function(data = data, cyc = 1, fluo.range = c(NA), 
                        Cq.range = c(NA, NA)) {
  cpD2 <- vector()
  cpD2.res <- vector()
  pb <- txtProgressBar(min = 1, max = length(fluo.range), initial = 0, style = 3)
  for (i in fluo.range) {
    cpD2.tmp <- efficiency(pcrfit(data = data, cyc = cyc, fluo = i, 
      model = l5), plot = FALSE)$cpD2
    cpD2 <- c(cpD2, cpD2.tmp)
    if (Cq.range[1] <= cpD2.tmp && cpD2.tmp <= Cq.range[2]) {cpD2.res.tmp <- 1} 
  else(cpD2.res.tmp <- 0)
    cpD2.res <- c(cpD2.res, cpD2.res.tmp)
    setTxtProgressBar(pb, i)
    }
  close(pb)
  out <- cbind(cpD2, cpD2.res)
  colnames(out) <- c("cpD2", "result")
  return(out)
  }

# Cq.range defines a range to convert cpD2 values into positive (1) 
# and negative (0) chambers.
# The dataset reps384 is used as sample.
# results.dPCR contains a column with the cpD2 values and a column with converted values.
Cq.range <- c(18.1, 18.3)
results.dPCR <- cpD2limiter(data = reps384, cyc = 1, fluo.range = c(2:ncol(reps384)),
                              Cq.range = Cq.range)
  
# Get the number of positive reactions k.tmp and the total number of reactions n.tmp. 
k.tmp <- sum(results.dPCR[,2]) # 191
n.tmp <- nrow(results.dPCR) # 379

# Generate an amplification plot from the reps384 data set along with the density  
# of the number of positive molecules or the average number of molecules per partition.
par(mfrow = c(1,2))
plot(NA, NA, xlim = c(1,45), ylim = c(0, 11000), xlab = "Cycle", ylab = "Fluo")
 rect(Cq.range[1], 0, Cq.range[2], 11000, col = "cyan")
 for (i in 2:ncol(reps384)) {
   lines(reps384[,1], reps384[, i] - mean(reps384[1:15, i]))
   }
dpcr_density(k = k.tmp, n = n.tmp)

}

\keyword{ dplot }
\keyword{ hplot }
