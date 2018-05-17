require './app/universe'
require './app/cell'

describe Universe, 'In this finite universe' do
  it 'initializes with a width and a height and generates dead cells' do
    universe = Universe.new(8,8)
    
    expect(universe.cells.length).to eql(64)
    expect(universe.cells.all? {|cell| cell.alive?}).to eq(false)    
  end

  it 'returns a cell at a x and y position' do
    universe = Universe.new(2, 2)

    expect(universe.cell_position(0,1)).to eql(universe.cells[1])
    expect(universe.cell_position(1,0)).to eql(universe.cells[2])
  end
  
end

describe Universe, '::let the game of life begin' do
  let(:universe) { Universe.new(4,4) }
  context 'First law of life generation: a cell dies if any less than 2 or more than 3 neighouring cells live;' do
    it 'dies if less than 2 neighbour cells are alive' do
      cell = universe.cell_position(1,1)
      cell.live!

      cell_left = universe.cell_position(0, 1)
      cell_left.live!

      universe.regenerate_cells!
      
      expect(cell.alive?).to eql(false)
    end

    it 'dies if more than 3 neighbour cells are alive' do
      cell = universe.cell_position(1,1)
      cell.live!

      cell_left = universe.cell_position(0, 1)
      cell_left.live!

      cell_top_left = universe.cell_position(0, 0)
      cell_top_left.live!

      cell_top_middle = universe.cell_position(1, 0)
      cell_top_middle.live!

      cell_top_right = universe.cell_position(2, 0)
      cell_top_right.live!

      universe.regenerate_cells!
  
      expect(cell.alive?).to eql(false)
    end
  end


  context 'Second law of life generation: a cell continues to live if exactly 2 or 3 neighouring cells live' do
    it 'lives if 2 neighbour cells are alive' do
      cell = universe.cell_position(1,1)
      cell.live!

      cell_left = universe.cell_position(0, 1)
      cell_left.live!

      cell_top_left = universe.cell_position(0, 0)
      cell_top_left.live!
      
      universe.regenerate_cells!
      
      expect(cell.alive?).to eql(true)
      expect(cell_left.alive?).to eql(true)
      expect(cell_top_left.alive?).to eql(true)

    end

    it 'lives if 3 neighbour cells are alive' do
      cell = universe.cell_position(1,1)
      cell.live!

      cell_left = universe.cell_position(0, 1)
      cell_left.live!

      cell_top_left = universe.cell_position(0, 0)
      cell_top_left.live!

      cell_top_middle = universe.cell_position(1, 0)
      cell_top_middle.live!

      universe.regenerate_cells!
      
      expect(cell.alive?).to eql(true)
      expect(cell_left.alive?).to eql(true)
      expect(cell_top_left.alive?).to eql(true)
      expect(cell_top_middle.alive?).to eql(true)

    end
  end

  context 'Third law of life generation: a dead cell comes live if exactly 3 neighouring cells live' do
    it 'comes back from the dead if exactly 3 neighbour cells are alive' do
      cell = universe.cell_position(1,1) #starting off dead

      cell_left = universe.cell_position(0, 1)
      cell_left.live!

      cell_top_left = universe.cell_position(0, 0)
      cell_top_left.live!

      cell_top_middle = universe.cell_position(1, 0)
      cell_top_middle.live!
      
      universe.regenerate_cells!
      
      expect(cell.alive?).to eql(true)
      
    end
  end
end