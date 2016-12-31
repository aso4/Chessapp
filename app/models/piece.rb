class Piece < ActiveRecord::Base
  belongs_to :game
  belongs_to :user

  def self.pieces
    %w(Pawn Rook Bishop Knight Queen King)
  end

  #should have a side eg. white or black
  #functionality of all the unique pieces
  #how far pieces can move. special cases for all.

  #determine if piece is obstructed to move
  def is_obstructed?(x_destination, y_destination)
    x_location = self.x_pos
    y_location = self.y_pos
    #check for vertical obstructions
    if x_location == x_destination
      y_location > y_destination ? incrementer = -1 : incrementer = 1
      y_pos = y_location + incrementer
      while y_pos != y_destination
        if game.pieces.where(x_pos: x_location, y_pos: y_pos).any?
          return true
        end
        y_pos += incrementer
      end
      return false
    #check for horizontal obstructions
    elsif y_location == y_destination
      x_location > x_destination ? incrementer = -1 : incrementer = 1
      x_pos = x_location + incrementer
      while x_pos != x_destination
        if game.pieces.where(y_pos: y_location, x_pos: x_pos).any?
          return true
        end
        x_pos += incrementer
      end
      return false
    #check for diagnol obstructions
    else
      raise error if (x_location - x_destination).abs != (y_location - y_destination).abs
      x_location > x_destination ? x_incrementer = -1 : x_incrementer = 1
      y_location > y_destination ? y_incrementer = -1 : y_incrementer = 1
      x_pos = x_location + x_incrementer
      y_pos = y_location + y_incrementer
      while x_pos != x_destination && y_pos != y_destination
        if games.pieces.where(x_pos: x_pos, y_pos: y_pos).any?
          return true
        end
        x_pos += x_incrementer
        y_pos += y_incrementer
      end
      return false
    end
  end
end
