# frozen_string_literal: true

require_relative 'Grid'

print 'Ingrese numero de Filas: '
fila = gets.chomp.to_i
puts ' '
print 'Ingrese numero de Columnas: '
columna = gets.chomp.to_i
puts ' '
print 'Ingrese numero de Generaciónes: '
gen = gets.chomp.to_i

game = Grid.new(fila, columna, gen)
game.juego
