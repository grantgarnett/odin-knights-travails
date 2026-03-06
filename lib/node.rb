# this node class represents a single square on a chess board
# with reference to the knights travails class
class Node
  attr_accessor :coords, :prev_move

  def initialize(coordinate, prev_move = nil)
    @coords = coordinate
    @prev_move = prev_move
  end

  def update_path(prev_move)
    @prev_move = prev_move
  end
end
