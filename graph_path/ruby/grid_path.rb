require 'set' # Using Set for visited check for potentially better lookup performance, though Array is fine too.

class GridPathFinder
  # Define the possible moves (Up, Down, Left, Right)
  MOVES = [
    [-1, 0], # Up
    [1, 0],  # Down
    [0, -1], # Left
    [0, 1]   # Right
  ].freeze

  def find_shortest_path(grid, start_position)
    rows = grid.length
    cols = grid[0].length
    start_row, start_col = start_position

    # --- Input Validation and Edge Cases ---

    # 1. Check if start position is out of bounds (optional based on constraints, but good practice)
    unless start_row.between?(0, rows - 1) && start_col.between?(0, cols - 1)
      # Or raise an error, depending on desired behavior for invalid input
      return -1
    end

    start_value = grid[start_row][start_col]

    # 2. Check if start position is an obstacle
    return -1 if start_value == 1

    # 3. Check if start position is already a charging station
    return 0 if start_value == 2

    # --- BFS Initialization ---

    # Queue stores elements as: [[row, col], distance]
    queue = Queue.new # Using Ruby's built-in Queue
    # Visited set stores coordinates as: [row, col]
    visited = Set.new

    # Enqueue the starting position and mark as visited
    queue << [start_position, 0]
    visited.add(start_position)

    # --- BFS Loop ---
    until queue.empty?
      current_pos, current_distance = queue.pop
      current_row, current_col = current_pos

      # Explore neighbors
      MOVES.each do |dr, dc|
        next_row = current_row + dr
        next_col = current_col + dc
        next_pos = [next_row, next_col]

        # --- Neighbor Validation ---

        # 1. Check bounds
        next unless next_row.between?(0, rows - 1) && next_col.between?(0, cols - 1)

        # 2. Check if already visited
        next if visited.include?(next_pos)

        # 3. Check cell type
        cell_value = grid[next_row][next_col]

        # Skip obstacles
        next if cell_value == 1

        # --- Process Valid Neighbor ---

        # Mark as visited *before* adding to queue
        visited.add(next_pos)

        # Check if it's a charging station
        if cell_value == 2
          return current_distance + 1 # Found the shortest path
        end

        # It's an open road (0), enqueue it
        queue << [next_pos, current_distance + 1]
      end
    end

    # --- No Path Found ---
    # If the queue becomes empty and we haven't returned, no path exists
    -1
  end
end
