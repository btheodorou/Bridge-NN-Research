using StaticArrays

struct dealPBN
  trump::Cint
  first::Cint
  currentTrickSuit::SVector{3, Cint}
  currentTrickRank::SVector{3, Cint}
  remainCards::SVector{80, Cchar}
end

struct solvedPlay
  number::Cint
  tricks::SVector{53, Cint}
end
solvedPlay() = solvedPlay(0, zeros(Cint, 53))

struct playTracePbn
  number::Cint
  cards::SVector{106, Cint}
end

struct futureTricks
  nodes::Cint
  cards::Cint
  suit::SVector{13, Cint}
  rank::SVector{13, Cint}
  equals::SVector{13, Cint}
  score::SVector{13, Cint}
end
futureTricks() = futureTricks(0, 0, zeros(Cint, 13), zeros(Cint, 13), zeros(Cint, 13), zeros(Cint, 13))

"""Not yet tested"""
function AnalysePlay()
  remainCards = MVector{80, Cchar}(undef)
  pbn = "N:QJ6.K652.J85.T98 873.J97.AT764.Q4 K5.T83.KQ9.A7652 AT942.AQ4.32.KJ3"
  for (i, c) in enumerate(pbn)
    remainCards[i] = c
  end
  remainCards[length(pbn)+1] = 0
  spades = 0
  north = 0
  deal = dealPBN(spades, north, zeros(Cint, 3), zeros(Cint, 3), remainCards)
  playTrace = playTracePbn(0, zeros(Cint, 106))
  solved = Ref{solvedPlay}(solvedPlay())
   
  result = ccall((:AnalysePlayPBN, "./libdds"), Cint, (dealPBN, playTracePbn, Ref{solvedPlay}, Cint),
    deal,
    playTrace,
    solved,
    Threads.threadid() - 1
    )
  return (result, futp[])
end

# Returns (solveBoardResult, futureTricks)
function SolveBoardPBN(deal)
  futp = Ref{futureTricks}(futureTricks())
   
  result = ccall((:SolveBoardPBN, "./libdds"), Cint, (dealPBN, Cint, Cint, Cint, Ref{futureTricks}, Cint),
    deal,
    -1, #target
    2, #solutions
    0, #mode
    futp,
    Threads.threadid() - 1
    )
  return (result, futp[])
end