/*
   Using DDS, a bridge double dummy solver.
   Copyright (C) 2006-2014 by Bo Haglund /
   2014-2016 by Bo Haglund & Soren Hein.
   See LICENSE and README.

   This file written by Brandon Theodorou
   to provide a command line interface for
   use in AlphaZero Double Dummy Agent
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <string>
#include "../include/dll.h"

int main()
{
  int target = -1;
  int solutions = 2;
  int mode 0;
  int threadIndex = 0;
  char line[80];

#if defined(__linux) || defined(__APPLE__)
  SetMaxThreads(0);
#endif

  while (true)
  {
    // Get the latest command line input
    string dealEncoding;
    getline(cin, dealEncoding);
    dealPBN dlPBN;
    futureTricks fut;

    // Begin splitting the string
    strtok(dealEncoding, "-");

    // Extract the information
    dlPBN.remainCards = strtok(dealEncoding, "-");
    dlPBN.trump = std::stoi(strtok(dealEncoding, "-"), nullptr);
    dlPBN.first = std::stoi(strtok(dealEncoding, "-"), nullptr);
    dlPBN.currentTrickSuit[0] = std::stoi(strtok(dealEncoding, "-"), nullptr);
    dlPBN.currentTrickRank[0] = std::stoi(strtok(dealEncoding, "-"), nullptr);
    dlPBN.currentTrickSuit[1] = std::stoi(strtok(dealEncoding, "-"), nullptr);
    dlPBN.currentTrickRank[1] = std::stoi(strtok(dealEncoding, "-"), nullptr);
    dlPBN.currentTrickSuit[2] = std::stoi(strtok(dealEncoding, "-"), nullptr);
    dlPBN.currentTrickRank[2] = std::stoi(strtok(dealEncoding, "-"), nullptr);

    // Solve the board
    SolveBoardPBN(dlPBN, target, solutions, mode, &fut, threadIndex);

    // Print the optimal moves
    for(int action = 0; action < fut.cards; action++)
    {
      int actionNumber = (fut.suit[action] * 13) + (fut.rank[action] - 2) + 1
      cout << actionNumber << " "
    }
  }
}