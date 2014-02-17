Game of Life for iOS
====================


![Animation](https://raw.github.com/iOSCowboy/GameOfLife/master/Images/Example.gif?token=612990__eyJzY29wZSI6IlJhd0Jsb2I6aU9TQ293Ym95L0dhbWVPZkxpZmUvbWFzdGVyL0ltYWdlcy9FeGFtcGxlLmdpZiIsImV4cGlyZXMiOjEzOTMyNDkwMTB9--a61de5ef0c1378ec78ae0207d34eee65122e3a5e)

Game of Life is a popular cellular automaton proposed by John Conway during the funky 70s. 

**Cellular automaton** is a fancy term for a grid* of *cells* with a finite number of states. 
The system has an initial state (input) and changes over time according to some fixed rules. These rules determine the new state of each cell in terms of its current state and the state of the cells surrounding it (called  *neighbours*).

*a grid can have any finite number of dimensions. 


Rules of Conway's Game of Life
------------------------------

1. Any live cell with fewer than two live neighbours dies, as if caused by under-population.
2. Any live cell with two or three live neighbours lives on to the next generation.
3. Any live cell with more than three live neighbours dies, as if by overcrowding.
4. Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

Implementation Notes
--------------------

* The cellular automata is contained in the class ```CWYCelullarMatrix```.
* Since only two states are required (living / dead) it is represented as an array of ```BOOL``` values. 
* Animations are handled by the view controller and done with transitions of CALayer objects.


Contribution
------------
Yes, please! Fork and submit your pull-requests or initiate a discussion by opening a ticket. 

Authors:
--------
* Hector Zarate ([@iOSCowboy](http://twitter.com/ioscowboy))

License
-------
Licensed under the MIT License.

