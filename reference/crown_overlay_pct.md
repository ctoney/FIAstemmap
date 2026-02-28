# Compute fractional tree canopy cover of a subplot/microplot by crown overlay

Compute fractional tree canopy cover of a subplot/microplot by crown
overlay

## Usage

``` r
crown_overlay_pct(plot_radius, tree_list)
```

## Arguments

- plot_radius:

  A numeric value giving the radius of the subplot/microplot.

- tree_list:

  A data frame containing tree records for the subplot/microplot. Must
  have columns `DIST` (stem distance from subplot center in same units
  as `plot_radius`), `AZIMUTH` (horizontal angle from subplot/microplot
  center to the stem location, in the range `0:359`) and `CRWIDTH` (tree
  crown width in the same units as `plot_radius` and `DIST`).

## Value

A numeric value for tree canopy cover as percent of the
subplot/microplot covered by a vertical projection of circular crowns.
