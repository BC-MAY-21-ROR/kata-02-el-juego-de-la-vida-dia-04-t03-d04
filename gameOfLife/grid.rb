# frozen_string_literal: true

require_relative 'Cell'

class Grid
  attr_reader :row, :column, :matriz

  def initialize(rows = 6, columns = 10, generations = 2)
    @row = rows
    @column = columns
    @noGeneraciones = generations
    @matriz = Array.new(rows) { Array.new(columns) }
    @matriz = fill_matriz(@matriz)
    @matriz = populate_random(@matriz)
  end

  def fill_matriz(matriz)
    (0..@row - 1).each do |r|
      (0..@column - 1).each do |c|
        matriz[r][c] = Cell.new
      end
    end
    matriz
  end

  def populate_random(matrix)
    (1..matrix.size - 2).each do |r|
      (1..matrix[r].size - 2).each do |c|
        x = rand(0..1)
        matrix[r][c].cambioCell(true, r, c) if x == 1
      end
    end
    matrix
  end

  def juego
    matriz = @matriz
    noGeneraciones = @noGeneraciones
    (1..noGeneraciones).each do |i|
      puts "Generación #{i}"
      if i == 1
      else
        matriz = next_generation(matriz)
      end
      print_matrix(matriz)
    end
  end

  def print_matrix(matrix)
    (0..matrix.size - 1).each do |r|
      (0..matrix[r].size - 1).each do |c|
        if matrix[r][c].isAlive
          print " *\t"
        else
          print " .\t"
        end
      end
      print "\n"
    end
    print "\n"
  end

  def next_generation(matrix)
    new_generation = matrix
    (1..matrix.size - 2).each do |r|
      (1..matrix[r].size - 2).each do |c|
        cell = matrix[r][c]
        alives = alive_neighbors(r, c)
        if cell.isAlive
          if alives < 2
            new_generation[r][c].cambioCell(false, r, c)
          elsif [2, 3].include?(alives)
            new_generation[r][c].cambioCell(true, r, c)
          elsif alives > 3
            new_generation[r][c].cambioCell(false, r, c)
          end
        elsif !cell.isAlive && alives == 3
          new_generation[r][c].cambioCell(true, r, c)
        end
      end
    end
    new_generation
  end

  def alive_neighbors(r, c)
    alives = 0
    (-1..1).each do |i|
      (-1..1).each do |l|
        alives += 1 if @matriz[r + i][c + l].isAlive
      end
    end
    alives -= 1 if @matriz[r][c].isAlive
    alives
  end
end
