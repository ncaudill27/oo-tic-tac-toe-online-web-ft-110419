class TicTacToe

    attr_accessor :board

    def initialize(board = nil)
        @board ||= Array.new 9, " "
    end

    WIN_COMBINATIONS = [
        [0,1,2], [3,4,5], [6,7,8],
        [0,3,6], [1,4,7], [2,5,8],
        [0,4,8], [2,4,6]
    ]

    def display_board

        puts " #{board[0]} | #{board[1]} | #{board[2]} "
        puts "-----------"
        puts " #{board[3]} | #{board[4]} | #{board[5]} "
        puts "-----------"
        puts " #{board[6]} | #{board[7]} | #{board[8]} "
    end

    def input_to_index(input)
        input.to_i - 1
    end

    def move(index, player)
        @board[index] = player
    end

    def position_taken?(index)
        @board[index] == " " ? false : true
    end

    def valid_move?(index)
        if index.between?(0,8)
            position_taken?(index) ? false : true
        end
    end

    def turn_count
        @board.count { |index| index == "X" || index == "O" }
    end

    def current_player
        turn_count.even? ? "X" : "O"
    end

    def turn
        move = input_to_index(gets.chomp)
        if valid_move?(move)
            move(move, current_player)
            display_board
        else
            turn
        end
    end

    def won?
        WIN_COMBINATIONS.any? do |array|
            check = array.collect { |elem| @board[elem] }
            return array if check == ["X","X","X"] || check == ["O", "O", "O"]
        end
    end

    def full?
        !@board.include? " "
    end

    def draw?
        full? && !won?
    end

    def over?
        turn_count == 9 || !!won? || draw?
    end

    def winner
        return turn_count.even? ? "O" : "X" if won?
    end

    def play
        turn until over?
        puts winner ? "Congratulations #{winner}!" : "Cat's Game!"    
    end
end