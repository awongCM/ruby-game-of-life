require './app/cell'
require './app/universe'

describe Cell do
  let(:universe) { Universe.new(5,5) }

  it 'initializes with an x and y position in some grid of the universe' do
    cell = Cell.new(universe, 0,0)

    expect(cell.x).to eq(0)
    expect(cell.y).to eql(0)
  end

  it 'starts off being dead' do
    cell = Cell.new(universe, 0,0)

    expect(cell.alive?).to be false
  end

  it 'should live' do
    cell = Cell.new(universe, 0,0)

    cell.live!
    expect(cell.alive?).to eql(true)
  end

  it 'can toggle to live when dead' do
    cell = Cell.new(universe, 0,0) #starts off dead

    cell.toggle!
    expect(cell.alive?).to eql(true)
  end

  it 'can toggle to die when alive' do
    cell = Cell.new(universe, 0,0)
    cell.live!

    cell.toggle!
    expect(cell.alive?).to eql(false)
  end

  it 'should die' do
    cell = Cell.new(universe, 0,0)

    cell.live!
    cell.dead!
    expect(cell.alive?).to eql(false)
  end

  it 'has neighbours' do
    cell = universe.cell_position(1,1)

    neighbour_cells = cell.fetch_neighbour_cells
    expect(neighbour_cells).to include(universe.cell_position(0,0))
    expect(neighbour_cells).to include(universe.cell_position(0,1))
    expect(neighbour_cells).to include(universe.cell_position(0,2))

    expect(neighbour_cells).to include(universe.cell_position(1,0))
    expect(neighbour_cells).to include(universe.cell_position(1,2))

    expect(neighbour_cells).to include(universe.cell_position(2,0))
    expect(neighbour_cells).to include(universe.cell_position(2,1))
    expect(neighbour_cells).to include(universe.cell_position(2,2))    

    expect(neighbour_cells.length).to eql(8)
  end

  it 'sees live neighbour cells around itself' do
    cell = universe.cell_position(1,1)

    top_right_corner_cell = universe.cell_position(cell.x - 1, cell.y)
    right_corner_cell = universe.cell_position(cell.x, cell.y + 1)

    top_right_corner_cell.live!
    right_corner_cell.live!

    live_neighour_cells = cell.fetch_live_neighbour_cells

    expect(live_neighour_cells.length).to eql(2)
    expect(live_neighour_cells).to include(top_right_corner_cell)
    expect(live_neighour_cells).to include(right_corner_cell)
    
  end

end