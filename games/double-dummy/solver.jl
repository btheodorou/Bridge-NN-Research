#####
##### Interface to Bo Haglund's Double Dummy Solver
##### https://github.com/dds-bridge/dds
#####

module Solver

import ..Game, ..history, ..WHITE
import AlphaZero: GI, GameInterface, Benchmark, AbstractPlayer, think

const DEFAULT_SOLVER_DIR = joinpath(@__DIR__, "solver", "dds") # TODO

struct Player <: AbstractPlayer{Game}
  process :: Base.Process
  lock :: ReentrantLock
  function Player(;
      solver_dir=DEFAULT_SOLVER_DIR,
      solver_name="c4solver", # TODO
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
    board = GI.current_state(g).board
    return "" # TODO
end

function query_solver(p::Player, g)
  hstr = hand_string(g)
  Base.lock(p.lock)
  println(p.process, hstr)
  l = readline(p.process)
  Base.unlock(p.lock)
  optimal_actions = map(split(l)) do x
    parse(Int64, x)
  end
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