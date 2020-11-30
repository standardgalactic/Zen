"""
    parse_toml(f::AbstractString, key::AbstractString, necessary::Bool)

Parse the configuration file (toml format)
"""
function parse_toml(f::AbstractString, key::AbstractString, necessary::Bool)
    if isfile(f)
        dict = TOML.parsefile(f)

        if haskey(dict, key)
            dict[key]
        else
            error("Do not have this key: $key in file: $f")
        end
    else
        if necessary
            error("Please make sure that the file $f really exists")
        else
            nothing
        end
    end
end

"""
    parse_toml(f::AbstractString, necessary::Bool)

Parse the configuration file (toml format)
"""
function parse_toml(f::AbstractString, necessary::Bool)
    if isfile(f)
        dict = TOML.parsefile(f)
    else
        if necessary
            error("Please make sure that the file $f really exists")
        else
            nothing
        end
    end
end

"""
    parse_dict(cfg::Dict{String,Any})
"""
function parse_dict(cfg::Dict{String,Any})
    case = cfg["case"]
    dft = cfg["dft"]
    dmft = cfg["dmft"]
    impurity = cfg["impurity"]
    solver = cfg["solver"]
end
