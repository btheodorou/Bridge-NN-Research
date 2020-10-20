#####
##### Interface to Bo Haglund's Double Dummy Solver
##### https://github.com/dds-bridge/dds
#####

module Solver

import ..Game, ..history, ..WHITE
import AlphaZero: GI, GameInterface, Benchmark, AbstractPlayer, think
include("dds.jl")

const leader_dict = Dict([(0, "N"), (1, "E"), (2, "S"), (3, "W")])
const rank_dict = Dict([(1, "2"), (2, "3"), (3, "4"), (4, "5"), (5, "6"), (6, "7"), (7, "8"), (8, "9"), (9, "T"), (10, "J"), (11, "Q"), (12, "K"), (13, "A")])

struct Player <: AbstractPlayer{Game} end

# Solver protocol
# - Standard input: current hand in desired dds Deal format
# - Standard output: FutureTricks data structure containing optimal actions

function hand_to_deal(p::Player, g)
  # Extract the board from the game
  board = GI.current_state(g).board
  
  # Calculate the trump suit
  if isnothing(findfirst(iszero, board[:,:,5]))
    trump = 5
  else
    trump = findfirst(x -> x == 1, board[:,:,5])[2]
  end
  trump -= 1
  
  # Calculate which player is up next
  first = maximum(g.board[:,:,6])
  
  # Calculate the cards that have been played in the current trick
  ct_ranks = zeros(Cint, 3)
  ct_suits = zeros(Cint, 3)
  if first > 0
    for i in 1:first
      card = findfirst(x -> x == i, board[:,:,6])
      ct_ranks[i] = card[1] + 1
      ct_suits[i] = card[2] - 1
    end
  end

  # Create the PBN representation of the remaining hands
  pbn = string("$(get(leader_dict, first, "")):$(join([join([join(reverse([get(rank_dict, index[1], "") for index in findall(x -> x == 0x01, board[:,i,j])])) for i in 1:4], ".") for j in 1:4], " "))")
  remainCards = MVector{80, Cchar}(undef)
  for (i, c) in enumerate(pbn)
    remainCards[i] = c
  end

  # Return the dds Deal data structure
  return dealPBN(trump, first, ct_suits, ct_ranks, remainCards)
end

function query_solver(p::Player, g)
  deal = hand_to_deal(p, g)
  result, fut = SolveBoardPBN(deal)
  if result != 1
    println(deal)
    println(fut)
    throw("Solver Query Failed: $result")
  end
  optimal_actions = [(fut.suit[i] * 13) + (fut.rank[i] - 2) + 1 for i in 1:fut.cards]
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
