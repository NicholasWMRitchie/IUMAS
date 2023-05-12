# IUMAS - An Introduction to the NeXL Packages

  * [NeXLCore](https://github.com/usnistgov/NeXLCore.jl) - Basic X-ray microanalysis algorithms and data
  * [NeXLMatrixCorrection](https://github.com/usnistgov/NeXLMatrixCorrection.jl) - Matrix correction for X-ray Microanalysis
  * [NeXLSpectrum](https://github.com/usnistgov/NeXLSpectrum.jl) - Spectrum and hyperspectrum processing

It has been prepared for IUMAS8, the 8th meeting of the International 
Union of Microbeam Analysis Societies being held June 2023 in Banff, Canada.

This code base is using the [Julia Language](https://julialang.org/) with the
[DrWatson](https://juliadynamics.github.io/DrWatson.jl/stable/) package
to make a reproducible scientific project named `IUMAS`.

## Instructions
To (locally) reproduce this project, do the following:

0. Install Julia version 1.9.0 from either 
   [archived old releases](https://julialang.org/downloads/oldreleases/) or 
   [current releases](https://julialang.org/downloads/) depending upon whether
   1.9.0 remains a current release.

1. Download this code base. You will need to download the entire project
   using either Git or by downloading and unpacking the entire project as
   a ZIP archive.

2. Open a Julia 1.9.0 console and do:
   ```julia
   julia> using Pkg
   julia> Pkg.add("DrWatson") # install globally, for using `quickactivate`
   julia> Pkg.activate("path/to/this/project")
   julia> Pkg.instantiate()
   ```

3. You can use either `Weave.jl` or Jupyter notebooks to execute
[Introduction to NeXL.ipynb](https://github.com/NicholasWMRitchie/IUMAS/blob/main/notebooks/Introduction%20to%20NeXL.ipynb).
In either case, you will benefit from starting [Julia with multi-threading.](https://docs.julialang.org/en/v1/manual/multi-threading/).

  * To use `Weave.jl` to execute the script and generate an HTML file containing the output from the notebook.
```julia
julia> using Pkg
julia> Pkg.add("Weave")
julia> using Weave
julia> weave(joinpath("path/to/this/project","IUMAS","notebooks","Introduction to NeXL.ipynb"), fig_ext=".svg")
```
It may take a couple of hours to execute the full script given it quantifies 
a mega-pixel spectrum image.  Alternatively, the line `block_size = 1` in code block ~30 
may be changed to `block_size = 16` to chuck the pixel data into 16 &times; 16 blocks which 
will process much faster.  Even then, first-time compilation will mean the script takes many minutes 
to execute.

  * To use Jupyter to interact with the notebook called "notebooks/Introduction to NeXL.ipynb".
Solid support for Jupypter notebooks is available through 
[MS Visual Studio Code](https://code.visualstudio.com/) with the 
[Julia extension](https://marketplace.visualstudio.com/items?itemName=julialang.language-julia)
and the [Jupyter Notebook extension](https://marketplace.visualstudio.com/items?itemName=ms-toolsai.jupyter).
It is also possible to use Python-based implementations of Jupyter notebooks using
the [IJulia package](https://github.com/JuliaLang/IJulia.jl).  See the 
[IJulia documentation](https://julialang.github.io/IJulia.jl/stable/manual/running/) for instructions.

## About DrWatson

This project uses [DrWatson](https://github.com/JuliaDynamics/DrWatson.jl) and the 
[Julia package manager](https://docs.julialang.org/en/v1/stdlib/Pkg/) to create a 
reproducible computational environment.  This carefully defined environment optimizes the
likelyhood of being able to reproduce a data analysis procedure on other computational 
devices and getting identical results. The `IUMAS` project specifies the precise
versions of the Julia language and all explicit and implicit dependendent packages (libraries)
to minimize the potential for configuration errors.  The `Pkg.instantiate()` command installs
and uses precisely the versions of each dependent package specified in the `manifest.toml` 
file. The result is that you will execute exactly the same code on your computer as I did
on mine.  `DrWatson` provides additional tools to ensure reproducibility like abstracting the
file paths to allow the project to be moved to any directory. `DrWatson` also provides a 
mechanism to cache and reuse results once computed to reduce redundant effort.