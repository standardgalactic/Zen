#
# project : pansy
# source  : Zen.jl
# author  : Li Huang (lihuang.dmft@gmail.com)
# status  : unstable
# comment :
#
# last modified: 2020/12/16
#

module Zen

#
# using standard library
#
# additional remarks:
#
# the TOML package is included in the standard library since v1.6
# so, please upgrade your julia environment if it is outdated 
#
using Printf
using TOML

#
# const.jl
#
# define some global numerical or string constants
#
# summary:
#
# I32, I64    -> numerical types
# F32, F64    -> numerical types
# C32, C64    -> numerical types
# __libname__ -> library's name
# __version__ -> version of zen
# __release__ -> released date of zen
# __authors__ -> authors of zen
#
include("const.jl")
#
export I32, I64
export F32, F64
export C32, C64
export __libname__
export __version__
export __release__
export __authors__

#
# types.jl
#
# define some dictionaries which contain the configuration parameters
# and some data structures
#
# summary:
#
# PCASE    -> dict for case
# PDFT     -> dict for dft engine
# PDMFT    -> dict for dmft engine
# PIMP     -> dict for quantum impurities
# PSOLVER  -> dict for quantum impurity solver
# IterInfo -> dict for iteration information
#
include("types.jl")
#
export PCASE
export PDFT
export PDMFT
export PIMP
export PSOLVER
export IterInfo

#
# config.jl
#
# to extract the configurations from external files or dictionaries
#
# summary:
#
# parse_toml   -> parse case.toml
# renew_config -> update dict (configuration)
# check_config -> check dict (configuration)
# _v           -> verify dict
# _c           -> shortcut to visit dict (case)  
# _d           -> shortcut to visit dict (dft)
# _m           -> shortcut to visit dict (dmft)
# _i           -> shortcut to visit dict (impurity)
# _s           -> shortcut to visit dict (solver)
#
include("config.jl")
#
export parse_toml
export renew_config
export check_config
export _v
export _c
export _d
export _m
export _i
export _s

#
# util.jl
#
# to provide some useful utility functions. they can be used tp query
# the environments, print the configurations, and parse the strings, etc.
#
# summary:
#
# @cswitch      -> C-style switch 
# require       -> check julia envirnoment
# query_args    -> query arguments
# query_cars    -> query input files
# query_zen     -> query home directory of zen
# query_dft     -> query home directory of dft engine
# view_case     -> print dict (case)
# view_dft      -> print dict (dft)
# view_dmft     -> print dict (dmft)
# view_impurity -> print dict (impurity)
# view_solver   -> print dict (solver)
# welcome       -> welcome
# goodbye       -> say goodbye
# sorry         -> say sorry
# message       -> print some message to the screen
# line_to_array -> transform a line to a string array
#
include("util.jl")
#
export @cswitch
export require
export query_args
export query_cars
export query_zen
export query_dft
export view_case
export view_dft
export view_dmft
export view_impurity
export view_solver
export welcome
export goodbye
export sorry
export message
export line_to_array

#
# base.jl
#
# to provide the core functions to control the dft engine, dmft engine,
# and impurity solver
#
# summary:
#
# make_trees -> make working directories
# make_incar -> make essential input files
# dft_init   -> init dft engine
# dft_run    -> execute dft calculation
# dft_save   -> finalize dft calculation
#
include("base.jl")
#
export make_trees
export make_incar
export dft_init
export dft_run
export dft_save

#
# vasp.jl
#
# adaptor for the vasp software package. it provide a lot of functions
# to deal with the vasp-related files
#
# summary:
#
# vaspio_lattice
# vaspio_kmesh
# vaspio_eigen
# vaspio_charge
#
include("vasp.jl")
#
export vaspio_poscar
export vaspio_ibzkpt
export vaspio_projcar
export vaspio_locproj
export vaspio_eigenval
export vaspio_chgcar

#
# ir.jl
#
# adaptor for the intermediate representation format
#
# summary:
#
# irio_lattice
# irio_kmesh
# irio_tetra
# irio_eigen
# irio_projs
#
include("ir.jl")
#
export irio_lattice
export irio_kmesh
export irio_tetra
export irio_projs
export irio_eigen

end
