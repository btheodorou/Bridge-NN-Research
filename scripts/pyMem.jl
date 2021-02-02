#####
##### pyMem.jl
##### Script to save the memory in a python
##### usable format for experimentation
#####

using AlphaZero
using Serialization: deserialize
using NPZ

memory_path = "sessions/double-dummy/mem.data"
memory = deserialize(memory_path)
states = [sample.s.board for sample in memory.buffer]
values = [sample.z for sample in memory.buffer]
policies = [sample.π for sample in memory.buffer]

println(typeof(states))
println(typeof(values))
println(typeof(policies))

# npzwrite("pyMem/states.npz", states)
# npzwrite("pyMem/values.npz", values)
# npzwrite("pyMem/states.policies", policies)