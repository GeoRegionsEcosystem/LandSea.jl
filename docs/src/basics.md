# How to use LandSea.jl

As mentioned on the [home](index) page, LandSea.jl is a backend package that allows a user to import and handle land-sea masks and topographic data. Examples of such land-sea mask datasets include:
* ERA5 reanalysis land-sea masks and topographic data (0.25º or T639 spectral)
* NASA IMERG land-sea mask (0.1º)
* ETOPO topographic datasets, with land-sea mask estimation

## Retrieving a LandSea Dataset

To retrieve Land-Sea dataset, we recommend extending the `getLandSea()` function exported by LandSea.jl as needed via the following method:

```julia
import LandSea: getLandSea

function getLandSea(
    ids :: <Dataset Type of Interest>,
    geo :: GeoRegion
)

...

end
```

See the docs below:
```@docs
getLandSea
```

## Examples

The following packages serve as examples of how LandSea.jl can be used to download topographic and land-sea mask information:
* ERA5Reanalysis.jl [(GitHub)](https://github.com/GeoRegionsEcosystem/ERA5Reanalysis.jl) [(documentation)](https://georegionsecosystem.github.io/ERA5Reanalysis.jl/stable/) [(source code)](https://github.com/GeoRegionsEcosystem/ERA5Reanalysis.jl/tree/main/src/landsea)
* NASAPrecipitation.jl [(GitHub)](https://github.com/GeoRegionsEcosystem/NASAPrecipitation.jl) [(documentation)](https://georegionsecosystem.github.io/NASAPrecipitation.jl/stable/) [(source code)](https://github.com/GeoRegionsEcosystem/NASAPrecipitation.jl/tree/main/src/landsea)