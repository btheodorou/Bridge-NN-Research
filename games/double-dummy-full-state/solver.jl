#####
##### Interface to Bo Haglund's Double Dummy Solver
##### https://github.com/dds-bridge/dds
#####

module Solver

import ..Game, ..history, ..WHITE
import AlphaZero: GI, GameInterface, Benchmark, AbstractPlayer, think

const DEFAULT_SOLVER_DIR = joinpath(@__DIR__, "solver", "dds", "bridge-nn")
const leader_dict = Dict([(0, "N"), (1, "E"), (2, "S"), (3, "W")])
const rank_dict = Dict([(1, "2"), (2, "3"), (3, "4"), (4, "5"), (5, "6"), (6, "7"), (7, "8"), (8, "9"), (9, "T"), (10, "J"), (11, "Q"), (12, "K"), (13, "A")])

struct Player <: AbstractPlayer{Game}
  process :: Base.Process
  lock :: ReentrantLock
  function Player(;
      solver_dir=DEFAULT_SOLVER_DIR,
      solver_name="DDSolver",
      disable_stderr=true)
    cmd = Cmd(`./$solver_name`, dir=solver_dir)
    if disable_stderr
      cmd = pipeline(cmd, stderr=devnull)
    end
    p = open(cmd, "r+")
    return new(p, ReentrantLock())
  end
end

# Solver protocol
# - Standard input: current hand in desired dds format
# - Standard output: space separated optimal action numbers

function hand_string(p::Player, g)
  # Extract the board from the game
  board = GI.current_state(g).board
  
  # Calculate the trump suit
  if isnothing(findfirst(iszero, board[:,:,5]))
    trump = 5
  else
    trump = findfirst(x -> x == 1, board[:,:,5])[2]
  end
  
  # Calculate which player is up next
  first = maximum(g.board[:,:,6])
  
  # Calculate the cards that have been played in the current trick
  ct_ranks = zeros(UInt8, 3)
  ct_suits = zeros(UInt8, 3)
  if first > 0
    for i in 1:first
      card = findfirst(x -> x == i, board[:,:,6])
      ct_ranks[i] = card[1] + 1
      ct_suits[i] = card[2] - 1
    end
  end

  # Create the PBN representation of the remaining hands
  pbn = string("$(get(leader_dict, first, "")):$(join([join([join(reverse([get(rank_dict, index[1], "") for index in findall(x -> x == 0x01, board[:,i,j])])) for i in 1:4], ".") for j in 1:4], " "))")

  # Return the string in the proper format
  return "$pbn-$trump-$first-$(ct_suits[1])-$(ct_ranks[1])-$(ct_suits[2])-$(ct_ranks[2])-$(ct_suits[3])-$(ct_ranks[3])-"
end

function query_solver(p::Player, g)
  hstr = hand_string(p, g)
  println(hstr)
  Base.lock(p.lock)
  println(p.process, hstr)
  l = readline(p.process)
  Base.unlock(p.lock)
  optimal_actions = map(split(l)) do x
    parse(Int64, x)
  end
  println(optimal_actions)
  return optimal_actions
end

function think(p::Player, g)
  as = GI.available_actions(g)
  opt_moves = query_solver(p, g)
  opt_mask = findall(x -> x in opt_moves, as)
  π = zeros(length(as))
  π[opt_mask] .= 1 / length(opt_mask)
  return as, π
end

Benchmark.PerfectPlayer(::Type{Game}) = Player

end