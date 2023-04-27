# IUMAS - An Introduction to the NeXL Packages

* [NeXLCore](https://github.com/usnistgov/NeXLCore.jl) - Basic X-ray microanalysis algorithms and data
* [NeXLMatrixCorrection]https://github.com/usnistgov/NeXLMatrixCorrection.jl) - Matrix correction for X-ray Microanalysis
* [NeXLSpectrum](https://github.com/usnistgov/NeXLSpectrum.jl) - Spectrum and hyperspectrum processing

It has been prepared for IUMAS8, the 8th meeting of the International 
Union of Microbeam Analysis Societies being held June 2023 in Banff, Canada.

This code base is using the [Julia Language](https://julialang.org/) and
[DrWatson](https://juliadynamics.github.io/DrWatson.jl/stable/)
to make a reproducible scientific project named
> IUMAS

To (locally) reproduce this project, do the following:

0. Install Julia version 1.8.5 from either 
   [archived old releases](https://julialang.org/downloads/oldreleases/) or 
   [current releases](https://julialang.org/downloads/) depending upon whether
   1.8.5 remains a current release.
1. Download this code base. You will need to download the entire project
   using either Git or by downloading and unpacking the entire project as
   a ZIP archive.
2. Open a Julia 1.8.5 console and do:
   ```
   julia> using Pkg
   julia> Pkg.add("DrWatson") # install globally, for using `quickactivate`
   julia> Pkg.activate("path/to/this/project")
   julia> Pkg.instantiate()
   ```

This will install all necessary packages for you to be able to run the scripts and
everything should work out of the box, including correctly finding local paths.

The primary executable is a Jypyter notebook called "notebooks/Introduction to NeXL.ipynb".
I use the Jupypter notebook support present in 
[MS Visual Studio Code](https://code.visualstudio.com/) with the 
[Julia extension](https://marketplace.visualstudio.com/items?itemName=julialang.language-julia)
and the [Jupyter Notebook extension](https://marketplace.visualstudio.com/items?itemName=ms-toolsai.jupyter).
It is also possible to use Python-based implementations of Jupyter notebooks using
the [IJulia package](https://github.com/JuliaLang/IJulia.jl).  See the IJulia website for
instructions.

This project uses [DrWatson](https://github.com/JuliaDynamics/DrWatson.jl) to create a 
reproducible computational environment.  The project specifies exact versions of the Julia
language and the necessary libraries (in `manifest.toml`) to minimize the potential for errors.  
DrWatson also abstracts file paths to allow the project to be moved to any directory.