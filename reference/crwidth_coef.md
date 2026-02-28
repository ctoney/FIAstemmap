# Regression coefficients for predicting tree crown width

A curated set of linear regression coefficients for predicting crown
width from stem diameter of tree species in the conterminous US.

## Usage

``` r
crwidth_coef
```

## Format

### `crwidth_coef`

A data frame with 430 rows and 8 columns:

- `symbol`:

  [`character`](https://rdrr.io/r/base/character.html), USDA PLANTS
  Database species symbol

- `SPCD`:

  [`integer`](https://rdrr.io/r/base/integer.html), FIA tree species
  code

- `common_name`:

  [`character`](https://rdrr.io/r/base/character.html), FIA tree species
  common name

- `surrogate`:

  [`character`](https://rdrr.io/r/base/character.html), Common name of
  surrogate species if applicable

- `b0`:

  [`numeric`](https://rdrr.io/r/base/numeric.html), Regression b0
  coefficient

- `b1`:

  [`numeric`](https://rdrr.io/r/base/numeric.html), Regression b1
  coefficient

- `b1`:

  [`numeric`](https://rdrr.io/r/base/numeric.html), Regression b2
  coefficient

- `reference`:

  [`character`](https://rdrr.io/r/base/character.html), Literature
  source of the species coefficients (see References)

## Details

The regression equation is of the general form:

    CRWIDTH = b0 + b1 * DIA + b2 * DIA^2

A quadratic term is not included in all cases. `CRWIDTH` is the
predicted tree crown diameter in feet, and `DIA` is FIA stem diameter in
inches.

In cases that species-specific equations were not available in the
literature, surrogate species were assigned based on subjectively
similar tree physiognomy.

## References

Bechtold, W.A. 2003. Crown-Diameter Prediction Models for 87 Species of
Stand-Grown Trees in the Eastern United States. *Southern Journal of
Applied Forestry*, Vol. 27, No. 4, 269-278.

Bechtold, W.A. 2004. Largest-Crown-Width Prediction Models for 53
Species in the Western United States. *Western Journal of Applied
Forestry*, Vol. 19, No. 4, 245-251.

Gill, S.J., G.S. Biging, E.C. Murphy. 2000. Modeling conifer tree crown
radius and estimating canopy cover. *Forest Ecology and Management*,
126, 405-416.
