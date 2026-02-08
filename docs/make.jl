using Documenter
using DocumenterVitepress
using LandSea

DocMeta.setdocmeta!(LandSea, :DocTestSetup, :(using LandSea); recursive=true)

makedocs(;
    modules  = [LandSea],
    authors  = "Nathanael Wong <natgeo.wong@outlook.com>",
    sitename = "LandSea.jl",
    doctest  = false,
    warnonly = true,
    format   = DocumenterVitepress.MarkdownVitepress(
        repo = "https://github.com/GeoRegionsEcosystem/LandSea.jl",
    ),
    pages=[
        "Home"            => "index.md",
        "Getting Started" => "basics.md",
        "Dataset Types"   => "landsea.md",
    ],
)

recursive_find(directory, pattern) =
    mapreduce(vcat, walkdir(directory)) do (root, dirs, files)
        joinpath.(root, filter(contains(pattern), files))
    end

files = []
for pattern in [r"\.cst", r"\.nc"]
    global files = vcat(files, recursive_find(@__DIR__, pattern))
end

for file in files
    rm(file)
end

DocumenterVitepress.deploydocs(;
    repo      = "github.com/GeoRegionsEcosystem/LandSea.jl.git",
    target    = "build", # this is where Vitepress stores its output
    devbranch = "main",
    branch    = "gh-pages",
)
