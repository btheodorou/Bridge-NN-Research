import AlphaZero.GI
using Random

# Initialize the dimension constants
const NUM_SUITS = 4
const NUM_VALUES= 13
const NUM_ARRAYS = 18
const NUM_CARDS = 52

# Initialize the player constants
const Player = UInt8
const WHITE = 0x01
const BLACK = 0x02
switch_players(p::Player) = 0x03 - p

# Initialize the board type
const Cell = UInt8
const EMPTY = 0x00
const Board = Array{Cell, 3}

# Initialize the deck
deck = zeros(UInt8, NUM_VALUES, NUM_SUITS, NUM_CARDS)
for i in 1:NUM_CARDS
  deck[:,:,i] = setindex!(deck[:,:,i],1,i)
end

#####
##### Define the Game
#####

mutable struct Game <: GI.AbstractGame
  board :: Board
  curplayer :: Player
  finished :: Bool
  trick_winner :: Player
  amask :: Vector{Bool} # actions mask
  # Actions history, which uniquely identifies the current board position
  # Used by external solvers
  history :: Union{Nothing, Vector{Int}}
end

function Game()
  board = random_starting_state(deck)
  curplayer = WHITE
  finished = false
  trick_winner = 0x00
  amask = get_legal_actions(board)
  history = Int[]
  Game(board, curplayer, finished, trick_winner, amask, history)
end

function Game(state)
  board = state.board
  curplayer = state.curplayer
  trick_winner = state.trick_winner
  amask = get_legal_actions(board)
  finished = !any(amask)
  history = Int[]
  Game(board, curplayer, finished, trick_winner, amask, history)
end

function GI.play!(g::Game, action)
  g.board = copy(g.board)
  isnothing(g.history) || push!(g.history, action)
  g.board[:,:,1] = setindex!(g.board[:,:,1], 0x00, action)
  g.board[:,:,6] = setindex!(g.board[:,:,6], maximum(g.board[:,:,6]) + 1, action)
  g.board[:,:,1:4] = circshift(g.board[:,:,1:4], (0,0,-1))
  update_status!(g)
  g.curplayer = switch_players(g.curplayer)
end

function GI.game_terminated(g::Game)
  return g.finished
end

GI.State(::Type{Game}) = typeof((board=zeros(UInt8, NUM_VALUES, NUM_SUITS, NUM_ARRAYS), curplayer=WHITE, trick_winner=WHITE))
GI.Action(::Type{Game}) = Int
GI.two_players(::Type{Game}) = true
const ACTIONS = collect(1:NUM_CARDS)
GI.actions(::Type{Game}) = ACTIONS
history(g::Game) = g.history
GI.actions_mask(g::Game) = g.amask
GI.current_state(g::Game) = (board=g.board, curplayer=g.curplayer, trick_winner=g.trick_winner)
GI.white_playing(::Type{Game}, state) = state.curplayer == WHITE

function GI.white_reward(g::Game)
  g.trick_winner == WHITE && (return  1.)
  g.trick_winner == BLACK && (return -1.)
  return 0.
end

#####
##### Helper Functions
#####

function random_starting_state(deck::Array{UInt8,3})
  # Initialize the hand
  board = zeros(UInt8, NUM_VALUES, NUM_SUITS, NUM_ARRAYS)

  # Shuffle the Deck
  deck = deck[:,:,shuffle(1:end)]

  # Create the hands
  for i in 1:4
    board[:,:,i] = sum(deck[:,:,(13*(i-1))+1:13*i], dims=3)
  end

  # Pick one of the five possible trump suits
  trump_suit = rand(1:5)
  if trump_suit == 5
    board[:,:,5] = ones(UInt8, NUM_VALUES, NUM_SUITS)
  else
    board[:,trump_suit,5] = ones(UInt8, NUM_VALUES)
  end 

  return board
end

function get_legal_actions(hand::Board)
  return vec(Array{Bool}(hand[:,:,1]))
end

function update_status!(g::Game)
  g.amask = get_legal_actions(g.board)
  g.finished = !any(g.amask)
  if maximum(g.board[:,:,6]) == 4
    g.trick_winner = calculate_winner(g.board)
    if !g.finished
      g.board[:,:,19-sum(g.board[:,:,1])] = g.board[:,:,6]
      g.board[:,:,6] = zeros(UInt8, NUM_VALUES, NUM_SUITS)
    end
  else
    g.trick_winner = 0x00
  end
end

function calculate_winner(board::Board)
  # Analyze the leading card
  leading_card = findfirst(x -> x == 1, board[:,:,6])
  winning_value = leading_card[1]
  winning_suit = leading_card[2]
  winning_player = 0x01
  if isnothing(findfirst(iszero, board[:,:,5]))
    trump_suit = 0x05
  else
    trump_suit = findfirst(x -> x == 1, board[:,:,5])[2]
  end

  # Loop through the other cards to calculate the winner
  for i in 2:4
    next_card = findfirst(x -> x == i, board[:,:,6])
    next_value = next_card[1]
    next_suit = next_card[2]
    if next_suit == trump_suit && winning_suit != trump_suit
      winning_suit = next_suit
      winning_value = next_value
      winning_player = i
    elseif next_suit == winning_suit && next_value > winning_value
      winning_value = next_value
      winning_player = i
    end
  end

  # Return the reward corresponding to the correct winner
  if winning_player == 1 || winning_player == 3
    return 0x01
  else
    return 0x02
  end
end

function Base.copy(g::Game)
  history = isnothing(g.history) ? nothing : copy(g.history)
  Game(g.board, g.curplayer, g.finished, g.trick_winner, copy(g.amask), history)
end

function Base.copy(state)
  return (board=copy(state.board), curplayer=state.curplayer, trick_winner=state.trick_winner)
end

#####
##### Simple heuristic for minmax
#####

function GI.heuristic_value(g::Game)
  # Find the trump suit
  if isnothing(findfirst(iszero, g.board[:,:,5]))
    trump_suit = 0x05
  else
    trump_suit = findfirst(x -> x == 1, g.board[:,:,5])[2]
  end

  # Add all of the card values (as higher values are better)
  mine = sum([card[1] for card in findall(x -> x == 0x01, g.board[:,:,1])]) + sum([card[1] for card in findall(x -> x == 0x01, g.board[:,:,3])])
  yours = sum([card[1] for card in findall(x -> x == 0x01, g.board[:,:,2])]) + sum([card[1] for card in findall(x -> x == 0x01, g.board[:,:,4])])

  # If the trump suit is a single suit, count those values again
  if trump_suit != 0x05
    mine += sum([card[1] for card in findall(x -> x == 0x01, g.board[:,trump_suit,1])]) + sum([card[1] for card in findall(x -> x == 0x01, g.board[:,trump_suit,3])])
    yours += sum([card[1] for card in findall(x -> x == 0x01, g.board[:,trump_suit,2])]) + sum([card[1] for card in findall(x -> x == 0x01, g.board[:,trump_suit,4])])
  end

  hvalue = mine - yours
  return convert(Float64, hvalue)
end

#####
##### ML interface
#####

function GI.vectorize_state(::Type{Game}, state)
  return convert(Array{Float32, 3}, state.board)
end

#####
##### Symmetries
#####

function flipped_board(board)
  return board[:,reverse(1:NUM_SUITS),:]
end

function GI.symmetries(::Type{Game}, state)
  symb = flipped_board(state.board)
  σ = vec(reshape(collect(1:NUM_CARDS), (NUM_VALUES, NUM_SUITS))[:,reverse(1:NUM_SUITS)])
  syms = (board=Board(symb), curplayer=state.curplayer, trick_winner=state.trick_winner)
  return [(syms, σ)]
end

#####
##### User interface
#####

GI.action_string(::Type{Game}, a) = string(a)

function GI.parse_action(g::Game, str)
  try
    p = parse(Int, str)
    1 <= p <= NUM_CARDS ? p : nothing
  catch
    nothing
  end
end

function GI.render(g::Game)
  if isnothing(findfirst(iszero, g.board[:,:,5]))
    trump_suit = 5
  else
    trump_suit = findfirst(x -> x == 1, g.board[:,:,5])[2]
  end
  println("Trump:" * string(trump_suit))
  println("Previous Reward: " * string(GI.white_reward(g)))
  println("Current Trick: " * string(findfirst(x -> x == 1, g.board[:,:,6])) * ", " * string(findfirst(x -> x == 2, g.board[:,:,6])) * ", " * string(findfirst(x -> x == 3, g.board[:,:,6])) * ", " * string(findfirst(x -> x == 4, g.board[:,:,6])))
  println("Hand 1:" * string(findall(x -> x == 0x01, g.board[:,:,1])))
  println("Hand 2:" * string(findall(x -> x == 0x01, g.board[:,:,2])))
  println("Hand 3:" * string(findall(x -> x == 0x01, g.board[:,:,3])))
  println("Hand 4:" * string(findall(x -> x == 0x01, g.board[:,:,4])))
end

function GI.read_state(::Type{Game})
  return nothing
end
