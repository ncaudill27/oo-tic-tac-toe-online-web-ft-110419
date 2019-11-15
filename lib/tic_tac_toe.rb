require 'pry'

class TicTacToe
  
  WIN_COMBINATIONS = [
    [0,1,2], [3,4,5], [6,7,8], # Horizontal Win
    [0,3,6], [1,4,7], [2,5,8], # Vertical Win
    [0,4,8], [2,4,6]           # Diagonal Win
    ]
  def initialize
    @board = Array.new 9, ' '
  end
  
  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end
  
  def input_to_index(command)
    command.to_i - 1
  end
  
  def move(index, marker)
    @board[index] = marker
  end
  
  def position_taken?(index)
    @board[index] == ' ' ? false : true
  end
  
  def valid_move?(index)
    if self.position_taken?(index) || index < 0 || index > 8
      false
    else
      true
    end
  end
  
  def turn_count
    @board.count { |turn| turn == "X" || turn == "O" }
  end
  
  def current_player
    turn_count.even? ? "X" : "O"
  end
  
  def turn
    move = gets
    move_location = input_to_index(move)
    move_valid = valid_move?(move_location)
    
    if move_valid
      @board[move_location] = current_player
      display_board
    else
      turn
    end
  end
  
  def won?
    WIN_COMBINATIONS.each do |combo|
      results = combo.collect do |number|
        @board[number]
      end
      
      if results == ["X","X","X"] || results == ["O","O","O"]
        return combo
      end
      
    end
    false
  end
  
  def full?
    turn_count == 9
  end
  
  def draw?
    !won? && !!full?
  end
  
  def over?
    (!!won? || !!draw?) && !!full?
  end
  
  def winner
    if !!won?
      turn_count.even? ? "O" : "X"
    else
      nil
    end
  end
  
  def play
    until over? do
      turn
    end
    
    if won?
      winner
    else
      puts "Cat's Game!"
    end
  end
  
end