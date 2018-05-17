class Cell  
  attr_reader :universe, :x, :y
  def initialize(universe, x,y)
    @universe, @x, @y = universe, x, y
    @alive = false
  end

  def alive?
    @alive    
  end

  def toggle!
    @alive = !@alive
  end

  def live!
    @alive = true
  end

  def dead!
    @alive = false
  end

  def fetch_neighbour_cells
    neighbour_cells = []
    
    neighbour_cells.push(@universe.cell_position(self.x-1, self.y-1));
    neighbour_cells.push(@universe.cell_position(self.x-1, self.y));
    neighbour_cells.push(@universe.cell_position(self.x-1, self.y+1));

    neighbour_cells.push(@universe.cell_position(self.x, self.y-1));
    neighbour_cells.push(@universe.cell_position(self.x, self.y+1));

    neighbour_cells.push(@universe.cell_position(self.x+1, self.y-1));
    neighbour_cells.push(@universe.cell_position(self.x+1, self.y));
    neighbour_cells.push(@universe.cell_position(self.x+1, self.y+1));

    neighbour_cells
  end

  def fetch_live_neighbour_cells
    live_neighbour_cells = []

    live_neighbour_cells = self.fetch_neighbour_cells.select {|neighbour_cell| neighbour_cell && neighbour_cell.alive?}

    live_neighbour_cells

  end

end