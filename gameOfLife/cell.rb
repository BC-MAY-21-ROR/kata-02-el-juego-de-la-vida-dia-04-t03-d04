# frozen_string_literal: true

class Cell
  attr_accessor :isAlive, :locationX, :locationY

  def initialize
    @isAlive = false
    @locationX = 0
    @locationY = 0
  end

  def cambioCell(estado, x, y)
    @isAlive = estado
    @locationX = x
    @locationY = y
  end
end
