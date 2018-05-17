require './app/cell'

class Universe
  def initialize(width, height)
    @cells = []
    width.times do |x|
      @cells.push([])
      height.times do |y|
        @cells[x].push(Cell.new(self, x , y))
      end
    end
  end

  def raw_cells
    @cells
  end

  def cells
    @cells.flatten
  end

  def cell_position(x,y)
    if @cells[x]
      @cells[x][y]
    end
  end

  def regenerate_cells!
    affected_cells = []
    cells.each do |cell|
      if (cell.alive? && cell.fetch_live_neighbour_cells.length < 2)
        affected_cells.push(cell)
      elsif (cell.alive? && cell.fetch_live_neighbour_cells.length > 3)
        affected_cells.push(cell)
      elsif (!cell.alive? && cell.fetch_live_neighbour_cells.length == 3)
        affected_cells.push(cell)
      end
    end
    
    affected_cells.each {|cell| cell.toggle!}
    return
  end

end