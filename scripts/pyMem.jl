#####
##### pyMem.jl
##### Script to save the memory in a python
##### usable format for experimentation
#####

using AlphaZero
using Serialization: deserialize
using NPZ

include("games.jl")
GAME = get(ENV, "GAME", "double-dummy")
SelectedGame = GAME_MODULE[GAME]
using .SelectedGame: Game

memory_path = "sessions/double-dummy/mem.data"
memory = deserialize(memory_path)

values = [sample.z for sample in memory]
states = zeros(UInt8, size(memory[1].s.board)[1], size(memory[1].s.board)[2], size(memory[1].s.board)[3], length(memory))
policies = zeros(Float64, 52, length(memory))

for i in 1:length(memory)
	for j in 1:size(memory[1].s.board)[3]
		for k in 1:size(memory[1].s.board)[2]
			for l in 1:size(memory[1].s.board)[1]
				states[l,k,j,i] = memory[i].s.board[l,k,j]
			end
		end
	end

	amask = GI.actions_mask(Game(memory[i].s))
	actions = zeros(size(amask))
	actions[amask] = memory[i].π
	policies[:,i] = actions
end

npzwrite("pyMem/states.npz", states)
npzwrite("pyMem/values.npz", values)
npzwrite("pyMem/states.policies", policies)
