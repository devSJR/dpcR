\name{plot_panel}
\alias{plot_panel}

\title{
Plot panel
}
\description{
  The \code{plot_panel} function takes objects of the class  \code{\linkS4class{adpcr}} to enable 
  customizable graphical representations of a chamber-based digital PCR experiments (e.g., Digital
  Array (R) IFCs (integrated fluidic circuits) of the BioMark (R) and EP1 (R)).
}
\usage{
plot_panel(input, nx, ny, col = "red", legend = TRUE, half = "none", ...)
}
\arguments{
  \item{input}{object of the \code{\linkS4class{adpcr}} class. See Details.}
  \item{nx}{Number of columns in a plate.}
  \item{ny}{Number of rows in a plate.}
  \item{col}{A single color or vector of colors for each level of input.}
  \item{legend}{If \code{TRUE}, a built-in legend is added to the plot.}
  \item{half}{If \code{left} or \code{right}, every well is represented only by the adequate half
  of the rectangle.}
  \item{...}{Arguments to be passed to \code{plot} function.}
}
\details{
Currently only objects containing only one column of data (one panel) can be plotted (see Examples 
how easily plot multipanel objects). Moreover the object must contain fluorescence intensities or 
exact number of molecules or the positive hits derived from the Cq values for each well.

If the \code{col} argument has length one, a color is assigned for each interval of the input, with
the brightest colors for the lowest values.
}
\value{
A list of coordinates of each microfluidic well and an assigned color.
}
\author{
Michal Burdukiewicz, Stefan Roediger.
}
\seealso{
\code{\link{extract_dpcr}}.
}
\examples{
# Create a sample dPCR experiment with 765 elements (~> virtual compartments)   
# of target molecule copies per compartment as integer numbers (0,1,2)
ttest <- sim_adpcr(m = 400, n = 765, times = 20, pos_sums = FALSE, 
                   n_panels = 1)
# Plot the dPCR experiment results with default settings
plot_panel(ttest, nx = 45, ny = 17)

# Apply a binary color code with blue as positive
ttest@breaks <- c(0, 2, 4)
plot_panel(ttest, nx = 45, ny = 17, col = "blue")

# Apply a two color code for number of copies per compartment
plot_panel(ttest, nx = 45, ny = 17, col = c("blue", "red"))

# supply customized breaks and compare
par(mfcol = c(2, 1))
plot_panel(ttest, nx = 45, ny = 17)
slot(ttest, "breaks") <- c(0, 1, 2, (max(slot(ttest, "breaks")) + 1))
plot_panel(ttest, nx = 45, ny = 17)
par(mfcol = c(1, 1))

# plot few panels
ttest2 <- sim_adpcr(m = 400, n = 765, times = 40, pos_sums = FALSE, 
                    n_panels = 4)
par(mfcol = c(2, 2))
four_panels <- lapply(1:ncol(ttest2), function(i) 
       plot_panel(extract_dpcr(ttest2, i), nx = 45, ny = 17, legend = FALSE, 
         main = paste("Panel", LETTERS[i], sep = " ")))
par(mfcol = c(1, 1))

# two different channels 
plot_panel(extract_dpcr(ttest2, 1), nx = 45, ny = 17, legend = FALSE, 
           half = "left")
par(new = TRUE)
plot_panel(extract_dpcr(ttest2, 2), nx = 45, ny = 17, col = "blue", 
           legend = FALSE, half = "right")

# plot two panels with every well as only the half of the rectangle
ttest3 <- sim_adpcr(m = 400, n = 765, times = 40, pos_sums = FALSE, 
                    n_panels = 2)
par(mfcol = c(1, 2))
two_panels <- lapply(1:ncol(ttest3), function(i) 
       plot_panel(extract_dpcr(ttest3, i), nx = 45, ny = 17, legend = FALSE, 
         main = paste("Panel", LETTERS[i], sep = " ")))
par(mfcol = c(1, 1))
}

\keyword{ hplot }
