# Load tree data from a file or database connection

`load_tree_data()` fetches tree records from a data source, most
commonly a comma-separated values (CSV) file, a SQLite database file
(.db, .sqlite, .gpkg), or a PostgreSQL database connection. Other data
sources are also possible. File-based sources can be read from
compressed archives without prior extraction (e.g., .zip), and
network-hosted files can be read directly without prior download (see
Details).

## Usage

``` r
load_tree_data(src, table = NULL, columns = DEFAULT_TREE_COLUMNS, sql = NULL)
```

## Arguments

- src:

  A character string specifying the data source as a file name or
  database connection string (see Details).

- table:

  Optional character string giving the name of a table in `src` from
  which tree records will be fetched. Generally needed with RDBMS
  sources containing multiple tables, as opposed to a single-table
  source such as a CSV file.

- columns:

  Optional character vector specifying a subset of column names in the
  source table to include in the result set.

- sql:

  Optional character string containing a SQL SELECT statement to execute
  on `src` (instead of selecting all records potentially from a subset
  of columns, i.e., mutually exclusive with `table` and/or `columns`).

## Value

A data frame containing the tree records fetched from `src`.

## Details

A data source is typically specified as one of the following: **WIP**
