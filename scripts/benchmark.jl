#####
##### Benchmark.jl
##### Script to run a new benchmark on a previous training session
##### (requires training with option `save_intermediate=true`)
#####

using AlphaZero

include("games.jl")
GAME = get(ENV, "GAME", "double-dummy-full-state")
SelectedGame = GAME_MODULE[GAME]
using .SelectedGame: Game, Training

SESSION_DIR = "sessions/$GAME"

alphazero = Benchmark.Full(Training.arena.mcts)
baselines = [Benchmark.Solver(ϵ=0), Training.minmax_baseline]

make_duel(player, baseline) =
  Benchmark.Duel(
    player,
    baseline,
    num_games=1,
    reset_every=1,
    flip_probability=0.0,
    color_policy=BASELINE_WHITE)

benchmark = [make_duel(alphazero, Benchmark.Solver(ϵ=0))]
label = "full"

AlphaZero.UserInterface.run_new_benchmark(
  Game, Training.Network{Game}, SESSION_DIR,
  label, benchmark,
  params=Training.params, itcmax=nothing)
