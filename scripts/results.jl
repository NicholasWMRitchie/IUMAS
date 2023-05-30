using DrWatson
@quickactivate "IUMAS"

using DataDeps

# Where do I want to put the data?

# ENV["DATADEPS_ALWAYS_ACCEPT"]="true"

register(DataDep("MnDeepSeaNoduleResults",
    """
    Dataset:       k-ratio and quantitative results for Deep Sea Manganese Nodule Dataset
    Acquired by:   Nicholas W.M. Ritchie
    License:       CC-SA 3.0
    """,
    raw"https://drive.google.com/uc?export=download&confirm=yTib&id=10cXvC7LZAujcyNllg1E3YYZAlNqTk38B",
    "7251c357fe6a64fa6de8f0195f109e3ef05342dd6fc25c45d809250e2e8df5ad",
    post_fetch_method=DataDeps.unpack
));

println("Downloaded Mn deep-sea nodule results to $(datadep"MnDeepSeaNoduleResults")")
outpath = joinpath(datadir(), "exp_pro")
mkpath(outpath)
for fn in ( "kratios_mode=Full_x_dim=1024_y_dim=1024.jld2", "quantify_mode=Full_x_dim=1024_y_dim=1024.jld2")
    mv(joinpath(datadep"MnDeepSeaNoduleResults", fn), joinpath(outpath, fn), force=true)
end
println("Downloaded Mn deep-sea nodule results moved to $outpath.")
