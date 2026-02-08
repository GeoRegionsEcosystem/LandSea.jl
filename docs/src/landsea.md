# What is a LandSea Dataset?

A `LandSeaData` type contains information on:
* The longitude and latitude that define the grid for the Land-Sea mask of the region of interest
* The Land-Sea mask containing information on how where land and ocean are in the region of interest
* The topography, where available, of the region of interest

```@docs
LandSeaData
```

The `LandSeaData` abstract type has two subtypes:
1. `LandSeaFlat` type, which contains only information on the Land-Sea mask but has no information on topography
2. `LandSeaTopo` type, which contains information on both the Land-Sea mask and the topography

## The `LandSeaFlat` Type

```@docs
LandSeaFlat
```
## The `LandSeaTopo` Type

```@docs
LandSeaTopo
```