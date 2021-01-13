#
# project : pansy
# source  : Zen.jl
# author  : Li Huang (lihuang.dmft@gmail.com)
# status  : unstable
# comment :
#
# last modified: 2021/01/13
#

module Zen

#
# using standard libraries
#
using LinearAlgebra
using Distributed
using Printf
using Dates

#
# using third-party libraries
#
# additional remarks:
#
# the TOML package is included in the standard library since v1.6
# so, please upgrade your julia environment if it is outdated
#
using TOML

#
# global.jl
#
# define some global numerical or string constants
#
# summary:
#
# I32, I64    -> numerical types (integer)
# F32, F64    -> numerical types (float)
# C32, C64    -> numerical types (complex)
# __LIBNAME__ -> name of this library
# __VERSION__ -> version of this library
# __RELEASE__ -> released date of this library
# __AUTHORS__ -> authors of this library
#
include("global.jl")
#
export I32, I64
export F32, F64
export C32, C64
export __LIBNAME__
export __VERSION__
export __RELEASE__
export __AUTHORS__

#
# types.jl
#
# define some dicts and structs, which contain the config parameters or
# represent some essential data structures
#
# summary:
#
# PCASE    -> dict for case
# PDFT     -> dict for dft engine
# PDMFT    -> dict for dmft engine
# PIMP     -> dict for quantum impurities
# PSOLVER  -> dict for quantum impurity solver
# IterInfo -> struct for iteration information
# Lattice  -> struct for crystallography information
# PrTrait  -> struct for projectors
# PrGroup  -> struct for groups of projectors
# PrGroupT -> struct for groups of projectors (transformed)
#
include("types.jl")
#
export PCASE
export PDFT
export PDMFT
export PIMP
export PSOLVER
export IterInfo
export Lattice
export PrTrait
export PrGroup
export PrGroupT

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
# _c           -> shortcut for visiting dict (case), return original value
# _d           -> shortcut for visiting dict (dft), return original value
# _m           -> shortcut for visiting dict (dmft), return original value
# _i           -> shortcut for visiting dict (impurity), return original value
# _s           -> shortcut for visiting dict (solver), return original value
# str_c        -> shortcut for visiting dict (case), return string
# str_d        -> shortcut for visiting dict (dft), return string
# str_m        -> shortcut for visiting dict (dmft), return string
# str_i        -> shortcut for visiting dict (impurity), return string
# str_s        -> shortcut for visiting dict (solver), return string
#
include("config.jl")
#
export parse_toml
export renew_config
export check_config
export _v
export _c, str_c
export _d, str_d
export _m, str_m
export _i, str_i
export _s, str_s

#
# util.jl
#
# to provide some useful utility functions. they can be used to query
# the environments, print the configurations, and parse the strings, etc.
#
# summary:
#
# @cswitch      -> C-style switch
# require       -> check julia envirnoment
# query_args    -> query arguments
# query_inps    -> query input files
# query_zen     -> query home directory of zen
# query_dft     -> query home directory of dft engine
# list_case     -> print dict (case)
# list_dft      -> print dict (dft)
# list_dmft     -> print dict (dmft)
# list_impurity -> print dict (impurity)
# list_solver   -> print dict (solver)
# welcome       -> print welcome message
# overview      -> print overview of zen
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
export query_inps
export query_zen
export query_dft
export list_case
export list_dft
export list_dmft
export list_impurity
export list_solver
export welcome
export overview
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
# make_trees   -> make working directories
# rm_trees     -> remove working directories
# adaptor_init -> init dft_dmft adaptor
# adaptor_run  -> launch dft_dmft adaptor
# adaptor_save -> backup files generated by dft_dmft adaptor
# dft_init     -> init dft engine
# dft_run      -> launch dft engine
# dft_save     -> backup files generated by dft engine
# dmft_init    -> init dmft engine
# dmft_run     -> launch dmft engine
# dmft_save    -> backup files generated by dmft engine
# solver_init  -> init quantum impurity solver
# solver_run   -> launch quantum impurity solver
# solver_save  -> backup files generated by quantum impurity solver
#
include("base.jl")
#
export make_trees
export rm_trees
export adaptor_init
export adaptor_run
export adaptor_save
export dft_init
export dft_run
export dft_save
export dmft_init
export dmft_run
export dmft_save
export solver_init
export solver_run
export solver_save

#
# ir.jl
#
# adaptor for the intermediate representation format
#
# summary:
#
# irio_lattice -> write lattice information
# irio_kmesh   -> write kmesh
# irio_tetra   -> write tetrahedra
# irio_eigen   -> write eigenvalues
# irio_projs   -> write projectors
# irio_fermi   -> write fermi level
# irio_charge  -> write charge density
#
include("ir.jl")
#
export irio_lattice
export irio_kmesh
export irio_tetra
export irio_eigen
export irio_projs
export irio_fermi
export irio_charge

#
# plo.jl
#
# tools for the projection on localized orbitals scheme
#
# summary:
#
# plo_group  -> setup groups of projectors
# plo_rotate -> rotate the projectors
# plo_window -> extract the projectors within a given energy window
# plo_orthog -> orthogonalize the projectors
# plo_diag   -> orthogonalizes a projector defined by a rectangular matrix
# plo_ovlp   -> calculate overlap matrix
# plo_dm     -> calculate density matrix
# plo_hamk   -> calculate local hamiltonian
# plo_dos    -> calculate density of states
# view_ovlp  -> show overlap matrix
# view_dm    -> show density matrix
# view_hamk  -> show local hamiltonian
# view_dos   -> show density of states
#
include("plo.jl")
#
export plo_group
export plo_rotate
export plo_window
export plo_orthog
export plo_diag
export plo_ovlp
export plo_dm
export plo_hamk
export plo_dos
export view_ovlp
export view_dm
export view_hamk
export view_dos

#
# tetra.jl
#
# implementation of analytical tetrahedron method
#
# summary:
#
#
include("tetra.jl")

#
# vasp.jl
#
# adaptor for the vasp software package. it provide a lot of functions
# to deal with the vasp-related files
#
# summary:
#
# vasp_init      -> prepare vasp's input files
# vasp_run       -> execute vasp program
# vasp_save      -> backup vasp's output files
# vasp_incar     -> make essential input file (INCAR)
# vasp_kpoints   -> make essential input file (KPOINTS)
# vasp_files     -> check essential output files
# vaspio_lattice -> read lattice information
# vaspio_kmesh   -> read kmesh
# vaspio_tetra   -> read tetrahedra
# vaspio_eigen   -> read eigenvalues
# vaspio_projs   -> read projectors
# vaspio_fermi   -> read fermi level
# vaspio_charge  -> read charge density
#
include("vasp.jl")
#
export vasp_init
export vasp_run
export vasp_save
export vasp_incar
export vasp_kpoints
export vasp_files
export vaspio_lattice
export vaspio_kmesh
export vaspio_tetra
export vaspio_eigen
export vaspio_projs
export vaspio_fermi
export vaspio_charge

"""
    __init__()

This function would be executed immediately after the module is loaded at
runtime for the first time
"""
function __init__() end

end
