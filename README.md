Game of Life for iOS
====================




The Game of Life is a popular cellular automaton proposed by John Conway during the funky 70s. 

**Cellular automaton** is a fancy term for a grid[1] of *cells* with a finite number of states. 
The system has an initial state (input) and changes over time according to some fixed rules. These rules determine the new state of each cell in terms of its current state and the state of the cells surrounding it (called  *neighbours*).

[1]: The grid can have any finite number of dimensions. 


Rules of Conway's Game of Life
------------------------------

1. Any live cell with fewer than two live neighbours dies, as if caused by under-population.
2. Any live cell with two or three live neighbours lives on to the next generation.
3. Any live cell with more than three live neighbours dies, as if by overcrowding.
4. Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

Implementation Notes
--------------------


Contribution
------------
Yes, please! Fork and submit your pull-requests or initiate a discussion by opening a ticket. 

Authors:
--------
* Hector Zarate ([@iOSCowboy](http://twitter.com/ioscowboy))

License
-------
Licensed under the MIT License.

