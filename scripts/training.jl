#####
##### Training.jl
##### Script to run a new training loop on old memory 
##### without additional self play and with custom parameters
##### to monitor the performance of loss and related benchmarks
#####

using AlphaZero

include("games.jl")
GAME = get(ENV, "GAME", "double-dummy")
SelectedGame = GAME_MODULE[GAME]
using .SelectedGame: Game, Training

SESSION_DIR = "sessions/$GAME"

include("trials/params.jl")
for trial in trials
    AlphaZero.UserInterface.train_and_monitor(Game, SESSION_DIR, trial.label, 50, Training.benchmark, trial.params, trial.netparams)
end