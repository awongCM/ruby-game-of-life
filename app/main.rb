require './app/cell'
require './app/universe'

# Start with four living cells on the grid
universe = Universe.new(4,4)
cell1 = universe.cell_position(1,1)
cell1.live!
cell2 = universe.cell_position(1,2)
cell2.live!
cell3 = universe.cell_position(2,1)
cell3.live!
cell4 = universe.cell_position(2,2)
cell4.live!

# Kick off the Game of Life!
5.times do
  universe.regenerate_cells!
  universe.cells.map {|cell| print " | " + cell.alive?.to_s + " | " }
end