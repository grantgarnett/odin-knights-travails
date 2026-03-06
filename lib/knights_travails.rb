require_relative "node"

# This class allows you to calculate the shortest path a knight
# can take from one position on a chess board to another.
class KnightsTravails
  VERTICES = [[0, 0], [0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7],
              [1, 0], [1, 1], [1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7],
              [2, 0], [2, 1], [2, 2], [2, 3], [2, 4], [2, 5], [2, 6], [2, 7],
              [3, 0], [3, 1], [3, 2], [3, 3], [3, 4], [3, 5], [3, 6], [3, 7],
              [4, 0], [4, 1], [4, 2], [4, 3], [4, 4], [4, 5], [4, 6], [4, 7],
              [5, 0], [5, 1], [5, 2], [5, 3], [5, 4], [5, 5], [5, 6], [5, 7],
              [6, 0], [6, 1], [6, 2], [6, 3], [6, 4], [6, 5], [6, 6], [6, 7],
              [7, 0], [7, 1], [7, 2], [7, 3], [7, 4], [7, 5], [7, 6], [7, 7]]
             .freeze

  KNIGHT_MOVE_DIRS = [[1, 2], [2, 1], [1, -2], [2, -1],
                      [-1, 2], [-2, 1], [-1, -2], [-2, -1]].freeze

  def initialize
    @board = generate_board
  end

  def knight_moves(start_pos, target)
    return unless VERTICES.include?(start_pos) && VERTICES.include?(target)

    start_node = find_node(start_pos)
    start_node.update_path("end")

    determine_shortest_path(start_node, target)
  end

  private

  def generate_board
    VERTICES.map { |vertex| Node.new(vertex) }
  end

  def reset_board
    @board.each do |node|
      node.update_path(nil)
    end
  end

  def determine_shortest_path(starting_node, target) # rubocop: disable Metrics/MethodLength
    queue = [starting_node]

    until queue.empty?
      current_node = queue.shift

      return shortest_path_from(current_node) if current_node.coords == target

      possible_next_moves = find_next_moves(current_node.coords)
      possible_next_moves.compact.each do |node|
        if node.prev_move.nil?
          node.update_path(current_node)
          queue << node
        end
      end
    end
  end

  # returns shortest path from target assuming shortest path has
  # been made by linking nodes iteratively back to starting position
  def shortest_path_from(target_node)
    path_arr = []
    current_node = target_node

    until current_node == "end"
      path_arr << current_node.coords
      current_node = current_node.prev_move
    end

    puts "You made it in #{path_arr.size - 1} moves! Here's your path: "
    path_arr.reverse!.each { |coord| print "#{coord} \n" }

    reset_board
    path_arr
  end

  def find_next_moves(coord)
    KNIGHT_MOVE_DIRS.map do |dir|
      find_node([coord[0] + dir[0], coord[1] + dir[1]])
    end
  end

  def find_node(position)
    @board.find { |square| square.coords == position }
  end
end

test = KnightsTravails.new

test.knight_moves([0, 0], [1, 0])
test.knight_moves([0, 0], [3, 3])
test.knight_moves([0, 0], [7, 7])
test.knight_moves([3, 4], [7, 6])
test.knight_moves([1, 1], [1, 1])
