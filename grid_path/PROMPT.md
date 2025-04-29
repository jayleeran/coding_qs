# Original prompt for "grid_path" exercise:

Problem Description:

You are given a 2D grid of size 10×10 representing a road network. Each cell in the grid can have one of three values:

0: Represents an open road, which you can traverse.
1: Represents an obstacle, which you cannot move through.
2: Represents a target (e.g. charging station).
You are given a starting position (row,column) within the grid. Your task is to find the length of the shortest path from the starting position to any target (cell with value 2). You can move up, down, left, or right to adjacent open road cells (cells with value 0).

Constraints:

The grid dimensions are 10×10.
The starting position will always be a valid cell within the grid.
The grid will contain at least one target.
Output:

Return the minimum number of steps required to reach any charging station from the starting position. If no path to a charging station exists, return −1.

Example:

grid = [
    [0, 0, 0, 1, 0, 0, 0, 0, 0, 0],
    [0, 1, 0, 0, 0, 1, 0, 0, 2, 0],
    [0, 0, 0, 1, 0, 0, 0, 1, 0, 0],
    [1, 0, 1, 0, 0, 0, 1, 0, 0, 0],
    [0, 0, 0, 1, 0, 1, 0, 0, 1, 0],
    [0, 1, 0, 0, 2, 0, 0, 1, 0, 0],
    [0, 0, 0, 1, 0, 0, 0, 0, 0, 1],
    [0, 1, 0, 0, 0, 1, 0, 2, 0, 0],
    [0, 0, 1, 0, 0, 0, 1, 0, 0, 0],
    [2, 0, 0, 0, 1, 0, 0, 0, 1, 0]
]
start_position = (0, 0)
In this example, the shortest path from (0,0) to the charging station at (5,4) would have a length of 9.