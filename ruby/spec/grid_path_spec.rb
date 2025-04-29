require_relative '../grid_path'

RSpec.describe GridPathFinder do
  # Use the example grid provided in the challenge description
  let(:example_grid) do
    [
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
  end

  # Instantiate the finder for each test
  let(:finder) { GridPathFinder.new }

  context "when using the example grid" do
    it "finds the shortest path from (0, 0)" do
      start_position = [0, 0]
      # Path: (0,0)->(1,0)->(2,0)->(2,1)->(2,2)->(3,1)->(4,1)->(4,2)->(5,2) -> Charger! Distance 9
      expect(finder.find_shortest_path(example_grid, start_position)).to eq(9)
    end

    it "finds the shortest path from a position closer to another charger" do
      start_position = [7, 6] # Close to (7,7) charger
      # Path: (7,6) -> (7,7) -> Charger! Distance 1
      expect(finder.find_shortest_path(example_grid, start_position)).to eq(1)
    end
  end

  context "when starting on a charging station" do
    it "returns 0" do
      grid = [
        [0, 0, 0],
        [0, 2, 0],
        [0, 0, 0]
      ]
      start_position = [1, 1]
      expect(finder.find_shortest_path(grid, start_position)).to eq(0)
    end
  end

  context "when no path exists" do
    it "returns -1" do
      grid = [
        [0, 1, 0],
        [1, 1, 1],
        [0, 1, 2]
      ]
      start_position = [0, 0]
      expect(finder.find_shortest_path(grid, start_position)).to eq(-1)
    end

    it "returns -1 when start is blocked" do
        grid = [
            [1, 1, 1],
            [1, 0, 1],
            [1, 1, 2]
        ]
        start_position = [1, 1] # Start is valid, but surrounded
        expect(finder.find_shortest_path(grid, start_position)).to eq(-1)
    end
  end

  context "with multiple chargers" do
    it "finds the path to the *closest* charger" do
      grid = [
        [0, 0, 0, 0, 2],
        [0, 1, 1, 1, 1],
        [0, 1, 0, 0, 0],
        [0, 1, 0, 1, 2],
        [2, 0, 0, 0, 0]
      ]
      start_position = [0, 0]
      # Path to (0,4) is 4 steps.
      # Path to (4,0) is 4 steps.
      expect(finder.find_shortest_path(grid, start_position)).to eq(4)
    end
  end

  context "with edge cases" do
    it "handles starting at a corner" do
      grid = [
        [0, 0, 1],
        [1, 0, 0],
        [1, 1, 2]
      ]
      start_position = [0, 0]
      # Path: (0,0)->(0,1)->(1,1)->(1,2)->(2,2) = 4 steps
      expect(finder.find_shortest_path(grid, start_position)).to eq(4)
    end

    it "handles starting at an edge" do
      grid = [
        [1, 1, 1],
        [0, 0, 2],
        [1, 1, 1]
      ]
      start_position = [1, 0]
      # Path: (1,0)->(1,1)->(1,2) = 2 steps
      expect(finder.find_shortest_path(grid, start_position)).to eq(2)
    end

    it "handles charger at a corner" do
        grid = [
          [2, 0, 1],
          [0, 0, 0],
          [1, 0, 0]
        ]
        start_position = [2, 2]
        # Path: (2,2)->(2,1)->(1,1)->(1,0)->(0,0) = 4 steps
        expect(finder.find_shortest_path(grid, start_position)).to eq(4)
      end
  end

  context "when charger is an immediate neighbor" do
    it "returns 1" do
      grid = [
        [0, 2, 0],
        [0, 0, 0],
        [0, 0, 0]
      ]
      start_position = [0, 0]
      expect(finder.find_shortest_path(grid, start_position)).to eq(1)
    end

     it "returns 1 even with obstacles nearby" do
      grid = [
        [0, 1, 0],
        [1, 2, 0],
        [0, 0, 0]
      ]
      start_position = [2, 1]
      # Path: (2,1) -> (1,1) = 1 step
      expect(finder.find_shortest_path(grid, start_position)).to eq(1)
    end
  end

  context "when start position is invalid (e.g., obstacle)" do
    # Although the prompt says start is always valid, let's consider this.
    # The BFS should handle this naturally if we check the start cell value.
    # If start is '1', it shouldn't be added to the queue initially.
    # If start is '2', it should return 0 immediately.
    # Let's refine the plan: Check start cell *before* initializing BFS.
    it "returns -1 if start is an obstacle" do
       grid = [
        [1, 0, 0],
        [0, 0, 0],
        [0, 0, 2]
      ]
      start_position = [0, 0] # Start on obstacle '1'
      expect(finder.find_shortest_path(grid, start_position)).to eq(-1)
    end
  end
end
