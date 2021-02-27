require 'pry'

class Tictactoe

  class InvalidInput < StandardError
  end

  def initialize()
    @board = [[' ',' ',' '],[' ',' ',' '],[' ',' ',' ']]
    @moves = 9
  end

  def print
    puts printable_board
  end

  def make_a_move(x, y, mark)
    raise InvalidInput, "Invalid mark" unless ['1','2','3'].include?(x)
    mark(translate_x(x), translate_y(y), mark)
    true
  rescue InvalidInput => e
    puts e.message
    false
  end

  def mark(x, y, mark)
    @board[x][y] = mark.downcase
  end

  def translate_x(x)
    raise InvalidInput, "Invalid value for horizontal axis" unless ['1','2','3'].include?(x)
    x.to_i - 1
  end

  def translate_y(y)
    raise InvalidInput, "Invalid value for horizontal axis" unless ['a','b','c'].include?(y)
    case y
    when 'a'
      0
    when 'b'
      1
    when 'c'
      2
    end
  end

  def clear
    @board = [[' ',' ',' '],[' ',' ',' '],[' ',' ',' ']]
  end

  def printable_board
    puts "*********"
    puts "  a|b|c\n\n"
    board = []
    @board.each_with_index do |r,i|
      board << "#{i} #{r[0]}|#{r[1]}|#{r[2]}"
      board << "  -----" unless i == 2
    end
    board
  end

  def over?
    return true if hz_win? || vr_win? || cr_win?
    return true if moves_left == 0
    false
  end

  def moves_left
    @moves
  end

  def cr_win?
    return false if @board[0][0] == " " && @board[2][0] == " "
    return true if @board[0][0] == @board[1][1] && @board[1][1] == @board[2][2] 
    return true if @board[0][2] == @board[1][1] && @board[1][1] == @board[2][0]
    false
  end

  def hz_win?
    line_of_three?(@board)
  end

  def vr_win?
    line_of_three?(twisted_board)
  end

  def twisted_board
    [@board.map{ |k| k[0] },@board.map{ |k| k[1] }, @board.map{ |k| k[2] }]
  end

  def line_of_three?(arr)
    win = false
    arr.each do |val|
      next if val.include?(" ")
      win = true if val[0] == val[1] && val[1] == val[2]
    end
    win
  end
end