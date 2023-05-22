using DrWatson
@quickactivate "IUMAS"

using NeXLSpectrum
using Gadfly
using DataFrames

#using Profile
#using PProf


# DataDeps is a utility for downloading data on demand from a URL
using DataDeps

# Where do I want to put the data?
ENV["DATADEPS_LOAD_PATH"] = joinpath(datadir(), "exp_raw")
ENV["DATADEPS_ALWAYS_ACCEPT"]="true"

# Register the data sets using the names "MnDeepSeaNodule" and "MnDeepSeaNoduleStandards"
register(DataDep("MnDeepSeaNodule",
    """
    Dataset:       Deep Sea Manganese Nodule
    Acquired by:   Nicholas W.M. Ritchie
    License:       CC-SA 3.0
    """,
    raw"https://data.nist.gov/od/ds/mds2-2467/MnNodule.tar.gz",
    "5b5b6623b8f4daca3ff3073708442ac5702ff690aa12668659875ec5642b458d",
    post_fetch_method=DataDeps.unpack
));

register(DataDep("MnDeepSeaNoduleStandards",
    """
    Dataset:       Standard Spectra for Deep Sea Manganese Nodule Dataset
    Acquired by:   Nicholas W.M. Ritchie
    License:       CC-SA 3.0
    """,
    raw"https://data.nist.gov/od/ds/mds2-2467/MnNodule_Standards.tar.gz",
    "69283ba72146932ba451e679cf02fbd6b350f96f6d012d50f589ed9dd2e35f1a",
    post_fetch_method=DataDeps.unpack
));


raw = readrplraw(joinpath(datadep"MnDeepSeaNodule","map[15]"))
les = LinearEnergyScale(0.0, 10.0)
props = Dict{Symbol,Any}(
    :LiveTime => 0.72*4.0*18.0*3600.0/(1024.0*1024.0),
    :BeamEnergy => 20.0e3,
    :TakeOffAngle => deg2rad(35.0),
    :ProbeCurrent => 1.0,
    :Name => "Deep Sea Mn Nodule",
)
hs = HyperSpectrum(les, props, raw, fov = (0.2, 0.2))

# This speeds up the processing by binning a 1024 x 1024 hyperspectrum to 1024/block_size x 1024/block_size.
block_size = 16
hs = block_size > 1 ? block(hs, (block_size, block_size)) : hs

refs = references( [
        reference(n"C", joinpath(datadep"MnDeepSeaNoduleStandards", "C std.msa")),
        reference(n"O", joinpath(datadep"MnDeepSeaNoduleStandards", "MgO std.msa")),
        reference(n"Na", joinpath(datadep"MnDeepSeaNoduleStandards", "NaCl std.msa")),
        reference(n"Mg", joinpath(datadep"MnDeepSeaNoduleStandards", "Mg std.msa")),
        reference(n"Al", joinpath(datadep"MnDeepSeaNoduleStandards", "Al std.msa")),
        reference(n"Si", joinpath(datadep"MnDeepSeaNoduleStandards", "Si std.msa")),
        reference(n"P", joinpath(datadep"MnDeepSeaNoduleStandards", "GaP std.msa")), 
        reference(n"S", joinpath(datadep"MnDeepSeaNoduleStandards", "FeS2 std.msa")), 
        reference(n"Cl", joinpath(datadep"MnDeepSeaNoduleStandards", "NaCl std.msa")), 
        reference(n"K", joinpath(datadep"MnDeepSeaNoduleStandards", "KBr std.msa")), 
        reference(n"Ca", joinpath(datadep"MnDeepSeaNoduleStandards", "CaF2 std.msa")), 
        reference(n"Ti", joinpath(datadep"MnDeepSeaNoduleStandards", "Ti std.msa")), 
        reference(n"Cr", joinpath(datadep"MnDeepSeaNoduleStandards", "Cr std.msa")), 
        reference(n"Mn", joinpath(datadep"MnDeepSeaNoduleStandards", "Mn std.msa")), 
        reference(n"Fe", joinpath(datadep"MnDeepSeaNoduleStandards", "Fe std.msa")), 
        reference(n"Ni", joinpath(datadep"MnDeepSeaNoduleStandards", "Ni std.msa")), 
        reference(n"Cu", joinpath(datadep"MnDeepSeaNoduleStandards", "Cu std.msa")), 
        reference(n"Zn", joinpath(datadep"MnDeepSeaNoduleStandards", "Zn std.msa")), 
        reference(n"Ag", joinpath(datadep"MnDeepSeaNoduleStandards", "Ag std.msa")), 
        reference(n"Ba", joinpath(datadep"MnDeepSeaNoduleStandards", "BaF2 std.msa"))     
    ], 132.0)

mode = :Full  # Single threaded took 92 seconds for :Fast or 6000 seconds for :Full (many cores take about 1/6 this.)

# krs = @time fit_spectrum(hs, refs, mode = mode)  

using FileIO, Parameters
x_dim, y_dim = size(hs)
data, file = produce_or_load(
        joinpath(datadir(),"exp_pro"), # Path
        @dict(mode, x_dim, y_dim),     # Configuration
        prefix="kratios", suffix="jld2" # Filename parameters
    ) do config
        Dict("kratios" => @time fit_spectrum(hs, refs, mode = mode, sigma=3.0)) # Zero k-ratios less that 3σ
end
@show file
krs = data["kratios"]

@time quantify(krs, name=hs[:Name], ty=Float32)

#Profile.Allocs.clear()

#quant = Profile.Allocs.@profile quantify(krs, name=hs[:Name], ty=Float32)

# Export pprof allocation profile and open interactive profiling web interface.
# PProf.Allocs.pprof()