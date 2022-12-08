class Board
  attr_reader #:cells
              

  def initialize
    @cells = cells
  end

  def cells 
    cells = {cell_1: "A1",
    cell_2: "A2",
    cell_3: "A3",
    cell_4: "A4",
    cell_5: "B1",
    cell_6: "B2",
    cell_7: "B3",
    cell_8: "B4",
    cell_9: "C1",
    cell_10: "C2",
    cell_11: "C3",
    cell_12: "C4",
    cell_13: "D1",
    cell_14: "D2",
    cell_15: "D3",
    cell_16: "D4"}
  end
  
  def valid_coordinate?(cell)
     cells.value?(cell)
  end
end
