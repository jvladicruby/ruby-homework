# Methods

## this method is used to print current board state
def print_board(board)
    i = -1
    3.times do
        3.times do
            print "#{board[i += 1]}"
        end
        puts ''
    end
end

## this method is used for interaction with players (move input and board field value assignment)
def move(board, player)
    puts "Player '#{player}' move."
    print 'Where do you want to play your move [0 - 8]? '
    field = gets.chomp
    field = field.to_i
	
    if field.between?(0, 8) then
        if (board[field] == "[ O ]") or (board[field] == "[ X ]") then
            puts 'That field is already occupied! Try again.'
	else
            puts "Set '#{player}' to field #{field}."
            board[field] = "[ #{player} ]"
        end
    else
        puts 'Wrong input! Try again using numbers from 0 to 8.'
    end
end

# Main

board = ["[ 0 ]", "[ 1 ]", "[ 2 ]", "[ 3 ]", "[ 4 ]", "[ 5 ]", "[ 6 ]", "[ 7 ]", "[ 8 ]"]

loop do
    # prints board
    print_board(board)

    # check whose turn it is
    player_selector = board.count("[ O ]")
    if (player_selector > board.count("[ X ]"))
        move(board, "X")
    else
        move(board, "O")
    end
end
