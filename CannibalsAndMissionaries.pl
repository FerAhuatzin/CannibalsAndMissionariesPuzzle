%call to start entire program
findSolution:-
    %start state and final state with the only known position at the moment
    allSave([3,3,left,0,0],[0,0,right,3,3],[[3,3,left,0,0]],_).

%This line is for declaring the recursive rule with the current position, the desired final position and the previous position as parameters
allSave([CL1,ML1,P1,CR1,MR1],[CL2,ML2,P2,CR2,MR2],Seen,MovesList):-
    %analyzes all possible moves from the current position and if it is possible returns the new position
    cross([CL1,ML1,P1,CR1,MR1],[CL3,ML3,P3,CR3,MR3]),
    %checks out if the new position is actually new or if it is cycling
    not(member([CL3,ML3,P3,CR3,MR3],Seen)),
    %makes the recursive call with the new position, again the final position, the concatenation of the new position with the old ones and the concatenation of the move just executed
    allSave([CL3,ML3,P3,CR3,MR3],[CL2,ML2,P2,CR2,MR2],[[CL3,ML3,P3,CR3,MR3]|Seen],[ [[CL3,ML3,P3,CR3,MR3],[CL1,ML1,P1,CR1,MR1]] | MovesList ]).

% when the list of the final position matches with the list of the next position executes this rule
allSave(_,_, _, MovesList):- 
    %calls the output rule to print the results
    output(MovesList).


output([]) :- nl. 
% The rule for printing receives the list of Moves lists(actually the list of lists)
output([[A,B]|MovesList]) :- 
    %calls recursively until it reaches the first move
	output(MovesList), 
    %when it does it prints the moves it made from begining to end
   	write(B), nl.


%gets the desired position to check if the move is possible
possible([CL,ML,CR,MR]):-
    %checks if the amount of missionares or canivals send to the 
    %other side was the right one and with that crossing it didn't send 
    %extra persons
    ML>=0, CL>=0, MR>=0, CR>=0,
    %checks the main rule in the left side 
    %(at least the same amount of M and C to not be eaten)
	(ML>=CL ; ML=0),
    %checks the main rule in the right side 
	(MR>=CR ; MR=0).
    
%TWO CANIVALS
%cross to analyze if crossing two cannivals from left to right is viable
cross([CL1,ML,left,CR1,MR],[CL2,ML,right,CR2,MR]):- 
    %Two canivals minus in the left side
    CL2 is CL1-2,
    %Two canivals plus in the right side
    CR2 is CR1+2,
    %is it possible to do it?
    possible([CL2,ML,CR2,MR])
    .
%cross to analyze if crossing two cannivals from right to left is viable
cross([CL1,ML,right,CR1,MR],[CL2,ML,left,CR2,MR]):- 
    %Two canivals plus in the left side
    CL2 is CL1+2,
    %Two canivals minus in the right side
    CR2 is CR1-2,
    %is it possible to do it?
    possible([CL2,ML,CR2,MR])
    .
%ONE CANIVAL
%cross to analyze if crossing one cannival from left to right is viable
cross([CL1,ML,left,CR1,MR],[CL2,ML,right,CR2,MR]):- 
    %One canivals minus in the left side
    CL2 is CL1-1,
    %One canivals plus in the right side
    CR2 is CR1+1,
    %is it possible to do it?
    possible([CL2,ML,CR2,MR])
    .
%cross to analyze if crossing one cannival from right to left is viable
cross([CL1,ML,right,CR1,MR],[CL2,ML,left,CR2,MR]):- 
    %One canivals plus in the left side
    CL2 is CL1+1,
    %One canivals minus in the right side
    CR2 is CR1-1,
    %is it possible to do it?
    possible([CL2,ML,CR2,MR])
    .
 %ONE MISSIONER
%cross to analyze if crossing one missioner from left to right is viable
cross([CL,ML1,left,CR,MR1],[CL,ML2,right,CR,MR2]):- 
    %One missioners minus in the left side
    ML2 is ML1-1,
    %One missioners plus in the right side
    MR2 is MR1+1,
    %is it possible to do it?
    possible([CL,ML2,CR,MR2])
    .
%cross to analyze if crossing one missioner from right to left is viable
cross([CL,ML1,right,CR,MR1],[CL,ML2,left,CR,MR2]):- 
    %One missioners plus in the left side
    ML2 is ML1+1,
    %One missioners minus in the right side
    MR2 is MR1-1,
    %is it possible to do it?
    possible([CL,ML2,CR,MR2])
    .
%TWO MISSIONERS
%cross to analyze if crossing two missioners from left to right is viable
cross([CL,ML1,left,CR,MR1],[CL,ML2,right,CR,MR2]):- 
    %Two missioners minus in the left side
    ML2 is ML1-2,
    %Two missioners plus in the right side
    MR2 is MR1+2,
    %is it possible to do it?
    possible([CL,ML2,CR,MR2])
    .  
%cross to analyze if crossing two missioners from right to left is viable
cross([CL,ML1,right,CR,MR1],[CL,ML2,left,CR,MR2]):- 
    %Two missioners plus in the left side
    ML2 is ML1+2,
    %Two missioners minus in the right side
    MR2 is MR1-2,
    %is it possible to do it?
    possible([CL,ML2,CR,MR2])
    .
%BOTH
%cross to analyze if crossing one and one from left to right is viable
cross([CL1,ML1,left,CR1,MR1],[CL2,ML2,right,CR2,MR2]):- 
    %One missioners minus in the left side
    ML2 is ML1-1,
    %One missioners plus in the right side
    MR2 is MR1+1,
    %One canival minus in the left side
    CL2 is CL1-1,
    %One canival plus in the right side
    CR2 is CR1+1,
    %is it possible to do it?
    possible([CL2,ML2,CR2,MR2])
    .
%cross to analyze if crossing one and one from right to left is viable
cross([CL1,ML1,right,CR1,MR1],[CL2,ML2,left,CR2,MR2]):- 
    %One missioners plus in the left side
    ML2 is ML1+1,
    %One missioners minus in the right side
    MR2 is MR1-1,
    %One canival plus in the left side
    CL2 is CL1+1,
    %One canival left in the right side
    CR2 is CR1-1,
    %is it possible to do it?
    possible([CL2,ML2,CR2,MR2])
    .