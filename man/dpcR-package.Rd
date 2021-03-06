\name{dpcR-package}
\alias{dpcR-package}
\alias{dpcR}
\docType{package}
\title{
Digital PCR analysis

}
\description{
The dpcR package is a collection of functions for a digital Polymerase Chain Reaction (dPCR) 
analysis. dPCR comprises methods to quantify nucleic acids, copy number variations (CNV), 
homo-/heterozygosity, and rare mutations (including single nucleotid polymorphisms (SNP)). The 
chemical basis of dPCR is similar to conventional PCR but the reaction-mix is divided into 
hundredths to thousands of small compartments with parallel amplifications reactions. The analysis 
is based on counting the number of positive compartments and to relate it to the total number of 
compartments be means of Poission statistics which enables an absolute quantification. The 
package includes plot functions, summary functions, data sets and simulations for dPCR and 
customizeable GUI creators for droplet digital PCRs and chamber-based digital PCRs. The authors of 
the package aim to include all statistical approaches published in peer-review literature and 
additional selected sources of expertise currently available and to make them available to the 
scientific community in an open and cross-platform environment. As such the dpcR packages has a 
list of expressions/functions and may serve in future a reference to a unified nomenclature in dpcR. 
The package is primarily targeted at researchers who which to use it with an existing technology or 
during the development of novel digital PCR systems. In addition the dpcR package provides 
interactive tools that can be used in classes or by individuals to better learn about digital PCR 
concepts and data interpretation.
}
\details{
\tabular{ll}{
Package: \tab dpcR\cr
Type: \tab Package\cr
Version: \tab 0.1.0\cr
Date: \tab 2013-09-07\cr
License: \tab GPL2 \cr
}
}

\author{
Michal Burdukiewicz, Stefan Roediger.

Maintainer: Michal Burdukiewicz <michalburdukiewicz@gmail.com>
}
\references{
Vogelstein, B. and K. W. Kinzler, \emph{Digital PCR}. PNAS, 1999. 96(16): p. 9236-9241.
%%MORE REFERENCES
}
\keyword{ package }
\seealso{
\link[qpcR]{qpcR.news}.
}
\examples{
adpcr <- sim_adpcr(m = 400, n = 765, times = 20, pos_sums = FALSE, n_panels = 1)
plot_panel(adpcr, 45, 17, col = "green")
pos_chambers <- sum(adpcr > 0)
dpcr_density(k = pos_chambers, n = 765)
}
