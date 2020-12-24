#
# project : pansy
# source  : types.jl
# author  : Li Huang (lihuang.dmft@gmail.com)
# status  : unstable
# comment :
#
# last modified: 2020/12/24
#

#
# Customized Dictionaries
#

#
# remarks:
#
# the values in the following dictionaries are actually arrays, which
# contain four elements
#     value[1] -> actually value
#     value[2] -> if it is 1, this key-value pair is mandatory
#                 if it is 0, this key-value pair is optional
#     value[3] -> numerical type
#     value[4] -> brief explanations
#

"""
    PCASE

Dictionary for configuration parameters: case summary
"""
PCASE = Dict{String,Any}(
            "case"     => [missing, 1, String, "system's name"]
        )

"""
    PDFT

Dictionary for configuration parameters: density functional theory calculations
"""
PDFT  = Dict{String,Any}(
            "engine"   => [missing, 1, String, "engine for density functional theory calculations"],
            "smear"    => [missing, 0, String, "scheme for smearing"],
            "kmesh"    => [missing, 0, String, "density of kmesh sampling in the brillouin zone"],
            "magmom"   => [missing, 0, String, "initial magnetic moment"],
            "lsymm"    => [missing, 0, Bool  , "whether the symmetry is considered"],
            "lspins"   => [missing, 0, Bool  , "whether the spin orientations are polarized"],
            "lspinorb" => [missing, 0, Bool  , "whether the spin-orbit coupling is considered"],
            "window"   => [missing, 0, Array , "energy window for generating optimal projectors"],
            "loptim"   => [missing, 0, Bool  , "try to optimize the generated projectors"],
            "lproj"    => [missing, 1, Bool  , "try to generate projectors"],
            "nproj"    => [missing, 1, I64   , "number of types of projectors"],
            "sproj"    => [missing, 1, Array , "scheme for generating projectors"],
        )

"""
    PDMFT

Dictionary for configuration parameters: dynamical mean-field theory calculations
"""
PDMFT = Dict{String,Any}(
            "mode"     => [missing, 1, I64   , "scheme of dynamical mean-field theory calculations"],
            "axis"     => [missing, 1, I64   , "imaginary-time axis or real-frequency axis"],
            "beta"     => [missing, 1, Real  , "inverse system temperature"],
            "niter"    => [missing, 0, I64   , "number of iterations"],
            "mixer"    => [missing, 0, Real  , "mixing factor"],
            "dcount"   => [missing, 0, String, "scheme of double counting term"],
            "cc"       => [missing, 0, Real  , "convergence criterion of charge"],
            "ec"       => [missing, 0, Real  , "convergence criterion of total energy"],
            "fc"       => [missing, 0, Real  , "convergence criterion of force"],
            "lcharge"  => [missing, 0, Bool  , "examine whether charge is converged"],
            "lenergy"  => [missing, 0, Bool  , "examine whether total energy is converged"],
            "lforce"   => [missing, 0, Bool  , "examine whether force is converged"],
        )

"""
    PIMP

Dictionary for configuration parameters: quantum impurity problems
"""
PIMP  = Dict{String,Any}(
            "nsite"    => [missing, 1, I64   , "number of impurity sites"],
            "atoms"    => [missing, 1, Array , "chemical symbols of impurity atoms"],
            "equiv"    => [missing, 1, Array , "equivalency of quantum impurity atoms"],
            "shell"    => [missing, 1, Array , "angular momenta of correlated orbitals"],
            "ising"    => [missing, 1, Array , "interaction types of correlated orbitals"],
            "occup"    => [missing, 1, Array , "nominal impurity occupancy"],
            "upara"    => [missing, 1, Array , "Coulomb interaction parameter"],
            "jpara"    => [missing, 1, Array , "Hund's coupling parameter"],
            "lpara"    => [missing, 1, Array , "spin-orbit coupling parameter"],
        )

"""
    PSOLVER

Dictionary for configuration parameters: quantum impurity solvers
"""
PSOLVER= Dict{String,Any}(
             "engine"  => [missing, 1, String, "name of quantum impurity solver"],
             "params"  => [missing, 1, Array , "parameter sets of quantum impurity solver"],
         )

#
# Customized Structs
#

"""
    IterInfo

Record the runtime information

.dmft1_iter -> number of iterations for dmft1 and quantum impurity solver
.dmft2_iter -> number of iterations for dmft2 and dft engine
.dmft_cycle -> number of dft + dmft iterations
.full_cycle -> counter for each iteration
"""
mutable struct IterInfo
    dmft1_iter :: I64
    dmft2_iter :: I64
    dmft_cycle :: I64
    full_cycle :: I64
end

"""
    Lattice

Contain the crystallography information

._case -> the name of system
.scale -> universal scaling factor (lattice constant), which is used to
          scale all lattice vectors and all atomic coordinates
.lvect -> three lattice vectors defining the unit cell of the system. its
          size is (3, 3)
.nsort -> number of sorts of atoms
.natom -> number of atoms
.sorts -> sorts of atoms. its size is (nsort, 2)
.atoms -> lists of atoms. its size is (natom)
.coord -> atomic positions are provided in cartesian coordinates or in
          direct coordinates (respectively fractional coordinates). its
          size is (natom, 3)
"""
mutable struct Lattice
    _case :: String
    scale :: F64
    lvect :: Array{F64,2}
    nsort :: I64
    natom :: I64
    sorts :: Array{Union{String,I64},2}
    atoms :: Array{String,1}
    coord :: Array{F64,2}
end

"""
    PrTrait

Essential information of projector

.site -> site in which the projector is defined
.l    -> quantum number l
.m    -> quantum number m
.desc -> projector's specification
"""
mutable struct PrTrait
    site  :: I64
    l     :: I64
    m     :: I64
    desc  :: String
end

"""
    PrGroup

Essential information of group of projectors

.site  -> site in which the projectors are defined. in principle, the
          projectors included in the same group should be defined at
          the same site (or equivalently atom)
.l     -> quantum number l. in principle, the projectors included in
          the same group should have the same quantum number l (but
          with different m)
.corr  -> if the projectors in this group are correlated
.shell -> type of correlated orbitals
.Pr    -> array. it contains the indices of projectors
.Tr    -> array. it contains the transformation matrix. this parameter
          can be useful to select certain subset of orbitals or perform
          a simple global rotation
"""
mutable struct PrGroup
    site  :: I64
    l     :: I64
    corr  :: Bool
    shell :: String
    Pr    :: Array{I64,1}
    Tr    :: Array{C64,2}
end

"""
    PrGroupT

Essential information of group of projectors (be transformed or rotated)

.site  -> site in which the projectors are defined. in principle, the
          projectors included in the same group should be defined at
          the same site (or equivalently atom)
.l     -> quantum number l. in principle, the projectors included in
          the same group should have the same quantum number l (but
          with different m)
.ndim  -> how many projectors are actually included in this group, which
          should be equal to the length of vector Pr
.corr  -> if the projectors in this group are correlated
.shell -> type of correlated orbitals
.Pr    -> array. it contains the indices of projectors
"""
mutable struct PrGroupT
    site  :: I64
    l     :: I64
    ndim  :: I64
    corr  :: Bool
    shell :: String
    Pr    :: Array{I64,1}
end

#
# Customized Constructors
#

"""
    IterInfo(iter::I64 = 0)

Outer constructor for IterInfo struct
"""
function IterInfo(iter::I64 = 0)
    IterInfo(iter, iter, iter, iter)
end


"""
    Lattice(_case::String, scale::F64, nsort::I64, natom::I64)

Outer constructor for Lattice struct
"""
function Lattice(_case::String, scale::F64, nsort::I64, natom::I64)
    # initialize the arrays
    lvect = zeros(F64, 3, 3)
    sorts = Array{Union{String,I64}}(undef, nsort, 2)
    atoms = fill("", natom)
    coord = zeros(F64, natom, 3)

    # call the default constructor
    Lattice(_case, scale, lvect, nsort, natom, sorts, atoms, coord)
end

"""
    PrTrait(site::I64, sort::String, desc::String)

Outer constructor for PrTrait struct
"""
function PrTrait(site::I64, desc::String)
    # angular character of the local functions on the specified sites
    # see the following webpage for more details
    #     https://www.vasp.at/wiki/index.php/LOCPROJ
    orb_labels = ("s",
                  "py", "pz", "px",
                  "dxy", "dyz", "dz2", "dxz", "dx2-y2",
                  "fz3", "fxz2", "fyz2", "fz(x2-y2)", "fxyz", "fx(x2-3y2)", "fy(3x2-y2)")

    # to make sure the specified desc is valid
    @assert desc in orb_labels

    # determine quantum numbers l and m according to desc
    lm = findfirst(x -> x === desc, orb_labels) - 1
    l = convert(I64, floor(sqrt(lm)))
    m = lm - l * l

    # call the default constructor
    PrTrait(site, l, m, desc)
end

"""
    PrGroup(site::I64, l::I64)

Outer constructor for PrGroup struct
"""
function PrGroup(site::I64, l::I64)
    # lshell defines a mapping from l (integer) to shell (string)
    lshell = Dict{I64,String}(
                 0 => "s",
                 1 => "p",
                 2 => "d",
                 3 => "f",
             )

    # setup initial parameters
    # they will be further initialized in vaspio_projs() and plo_group()
    corr  = false
    shell = lshell[l]

    # allocate memory for Pr and Tr
    # they will be further initialized in vaspio_projs() and plo_group()
    max_dim = 7 # for f-electron system
    Pr = zeros(I64, max_dim)
    Tr = zeros(C64, max_dim, max_dim)

    # call the default constructor
    PrGroup(site, l, corr, shell, Pr, Tr)
end

"""
    PrGroupT(site::I64, l::I64, ndim::I64, corr::Bool, shell::String)

Outer constructor for PrGroupT struct
"""
function PrGroupT(site::I64, l::I64, ndim::I64, corr::Bool, shell::String)
    # allocate memory for Pr
    Pr = zeros(I64, ndim)

    # call the default constructor
    PrGroupT(site, l, ndim, corr, shell, Pr)
end
