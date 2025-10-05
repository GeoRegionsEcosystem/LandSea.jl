module LandSea

using Dates
# using ImageFiltering
using Logging

import Base: show

## Exporting the following functions:
export
        LandSeaData, LandSeaTopo, LandSeaFlat,
        getLandSea
        #smooth, smooth!, smoothlsm

## Abstract Types
"""
    LandSeaData

Abstract supertype for LandSea Datasets. All `LandSeaData` types contain the following fields:
* `lon` - Vector containing the longitude points for the Land-Sea Dataset
* `lat` - Vector containing the latitude points for the Land-Sea Dataset
* `lsm` - Array containing data regarding the Land-Sea Mask. 1 is Land, 0 is Ocean, NaN is outside the bounds of the GeoRegion
"""
abstract type LandSeaData end

"""
    LandSeaTopo <: LandSeaData

A LandSea Dataset that also contains information on the topographic height.

A `LandSeaTopo` type will also contain the following field:
* `z` - Array containing data regarding the Orographic Height in meters. NaN is outside the bounds of the GeoRegion
"""
struct LandSeaTopo{FT1<:Real,FT2<:Real} <: LandSeaData

    lon :: Vector{FT1}
    lat :: Vector{FT1}
    lsm :: Union{Vector{FT2},Array{FT2,2}}
    z   :: Union{Vector{FT2},Array{FT2,2}}

    function LandSeaTopo(
        lon :: Vector{FT1}, lat :: Vector{FT1},
        lsm :: Vector{FT2}, z   :: Vector{FT2}
    ) where {FT1 <: Real, FT2 <: Real}
        npnt = length(lsm)
        if (npnt!=length(lon)) || (npnt!=length(lat))
            error("$(modulelog()) - Longitudes, Latitudes and Unstructured Grid Land-Sea Mask must all have the same length")
        end
        npnt = length(z)
        if (npnt!=length(lon)) || (npnt!=length(lat))
            error("$(modulelog()) - Longitudes, Latitudes and Unstructured Grid Topography must all have the same length")
        end
        return new{FT1,FT2}(lon,lat,lsm,z)
    end

    function LandSeaTopo(
        lon :: Vector{FT1}, lat :: Vector{FT1},
        lsm :: Matrix{FT2}, z   :: Matrix{FT2}
    ) where {FT1 <: Real, FT2 <: Real}
        nlon,nlat = size(lsm)
        if (nlon!=length(lon)) || (nlat!=length(lat))
            error("$(modulelog()) - The Land-Sea Mask array must be of the same size as the grid defined by the Longitude and Latitude vectors")
        end
        nlon,nlat = size(z)
        if (size(lsm)!=size(z))
            error("$(modulelog()) - The Topography array must be of the same size as the grid defined by the Longitude and Latitude vectors")
        end
        return new{FT1,FT2}(lon,lat,lsm,z)
    end

    function LandSeaTopo(
        :: Vector{FT1}, :: Vector{FT1},
        :: Vector{FT2}, :: Matrix{FT2}
    ) where {FT1 <: Real, FT2 <: Real}
        error("$(modulelog()) - The `lsm` and `z` fields must both be vectors or both be matrices")
    end

    function LandSeaTopo(
        :: Vector{FT1}, :: Vector{FT1},
        :: Matrix{FT2}, :: Vector{FT2}
    ) where {FT1 <: Real, FT2 <: Real}
        error("$(modulelog()) - The `lsm` and `z` fields must both be vectors or both be matrices")
    end

end

"""
    LandSeaFlat <: LandSeaData

A LandSea Dataset that contains only information on the land-sea mask and no topography.
"""
struct LandSeaFlat{FT1<:Real,FT2<:Real} <: LandSeaData

    lon :: Vector{FT1}
    lat :: Vector{FT1}
    lsm :: Union{Vector{FT2},Array{FT2,2}}

    function LandSeaFlat(
        lon :: Vector{FT1}, lat :: Vector{FT1}, lsm :: Vector{FT2}
    ) where {FT1 <: Real, FT2 <: Real}
        npnt = length(lsm)
        if (npnt!=length(lon)) || (npnt!=length(lat))
            error("$(modulelog()) - Longitudes, Latitudes and Unstructured Grid Land-Sea Mask must all have the same length")
        end
        return new{FT1,FT2}(lon,lat,lsm)
    end
    
    function LandSeaFlat(
        lon :: Vector{FT1}, lat :: Vector{FT1}, lsm :: Matrix{FT2}
    ) where {FT1 <: Real, FT2 <: Real}
        nlon,nlat = size(lsm)
        if (nlon!=length(lon)) || (nlat!=length(lat))
            error("$(modulelog()) - The Land-Sea Mask array must be of the same size as the grid defined by the Longitude and Latitude vectors")
        end
        return new{FT1,FT2}(lon,lat,lsm)
    end

end

modulelog() = "$(now()) - LandSea.jl"

"""
    getLandSea

An extensible function type to retrieve LandSea Datasets. You can use this function name in your packages if you want to retrieve a specific LandSea dataset.
"""
function getLandSea end

# include("smooth.jl")
include("show.jl")

end
