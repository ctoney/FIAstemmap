# FIA stem map

**This is an implementation update, currently in-development**

The Forest Inventory and Analysis (FIA) Program of USDA Forest Service
provide tree-level measurements from a systematic grid of field plots
across all forest ownerships and land uses in the US. **FIAstemmap** is
an R package for mapping tree stem locations on FIA plots, modeling
individual crown dimensions, and generating plot-level estimates of
fractional tree canopy cover. Several stand height metrics can be
calculated. Spatial analysis of tree point pattern is facilitated for
the standard FIA four-point cluster plot design. Efficient data
processing supports national applications. The package provides an
updated implementation of the software originally described by Toney et
al. 2009 [\[1\]](#References). The original implementation for modeling
plot canopy cover from individual tree measurements has supported
several applications of FIA data, including:

- reference data for classifying vegetation types and mapping tree
  canopy cover in the LANDFIRE Program [\[2, 3\]](#References)
- National Land Cover Database (NLCD) Tree Canopy Cover (TCC) science
  and development [\[4\]](#References)
- wildlife habitat analysis [\[5\]](#References)
- comparative assessments of tree canopy cover estimation methods [\[6,
  7\]](#References)

## Installation

You can install the development version of **FIAstemmap** with:

``` r
# install.packages("pak")
pak::pak("ctoney/FIAstemmap")
```

## Example

TODO…

``` r
library(FIAstemmap)
## basic example code
```

## References

\[1\] Toney, Chris; Shaw, John D.; Nelson, Mark D. 2009. A stem-map
model for predicting tree canopy cover of Forest Inventory and Analysis
(FIA) plots. In: McWilliams, Will; Moisen, Gretchen; Czaplewski, Ray,
comps. *Forest Inventory and Analysis (FIA) Symposium 2008*; October
21-23, 2008; Park City, UT. Proc. RMRS-P-56CD. Fort Collins, CO: U.S.
Department of Agriculture, Forest Service, Rocky Mountain Research
Station. 19 p. Available:
<https://research.fs.usda.gov/treesearch/33381>.

\[2\] LANDFIRE: LANDFIRE Existing Vegetation Cover layer. (LF2024
version releasd 2025 - last update). U.S. Department of Interior,
Geological Survey, and U.S. Department of Agriculture. \[Online\].
Available: <https://landfire.gov/vegetation/evc> \[accessed 2026, Feb
24\].

\[3\] Moore, Annabelle; La Puma, Inga; Dillon, Greg; Smail, Tobin;
Schleeweis, Karen; Toney, Chris; Menakis, Jim; Bastian, Henry; Picotte,
Josh; Dockter, Daryn; Tolk, Brian. 2024. Twenty years of science and
management with LANDFIRE. Connected Science, October 2024. Fort Collins,
CO: U.S. Department of Agriculture, Forest Service, Rocky Mountain
Research Station. 2 p. Available:
<https://research.fs.usda.gov/treesearch/68397>.

\[4\] Toney, Chris; Liknes, Greg; Lister, Andy; Meneguzzo, Dacia. 2012.
Assessing alternative measures of tree canopy cover: Photo-interpreted
NAIP and ground-based estimates. In: McWilliams, Will; Roesch, Francis
A. eds. 2012. *Monitoring Across Borders: 2010 Joint Meeting of the
Forest Inventory and Analysis (FIA) Symposium and the Southern
Mensurationists*. e-Gen. Tech. Rep. SRS-157. Asheville, NC: U.S.
Department of Agriculture, Forest Service, Southern Research Station.
209-215. Available: <https://research.fs.usda.gov/treesearch/41009>.

\[5\] Tavernia, B., Nelson, M., Goerndt, M., Walters, B., & Toney, C.
(2013). Changes in forest habitat classes under alternative climate and
land-use change scenarios in the northeast and midwest, USA.
*Mathematical and Computational Forestry & Natural-Resource Sciences*
(MCFNS), **5**:2, 135-150(15). Retrieved from
<https://www.mcfns.com/index.php/Journal/article/view/MCFNS_165>.

\[6\] Riemann, R., Liknes, G., O’Neil-Dunne, J., Toney, C., Lister, T.
(2016). Comparative assessment of methods for estimating tree canopy
cover across a rural-to-urban gradient in the mid-Atlantic region of the
USA. *Environmental Monitoring and Assessment* **188**:297.
<https://doi.org/10.1007/s10661-016-5281-8>.

\[7\] Andrew N. Gray, Anne C.S. McIntosh, Steven L. Garman, Michael A.
Shettles. 2021. Predicting canopy cover of diverse forest types from
individual tree measurements. *Forest Ecology and Management*, Volume
501, 119682, ISSN 0378-1127,
<https://doi.org/10.1016/j.foreco.2021.119682>.
