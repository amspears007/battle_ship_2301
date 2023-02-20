require 'spec_helper'

RSpec.describe Computer do
  it 'initializes' do
    comp = Computer.new
    expect(comp).to be_instance_of(Computer)
  end

  it 'allows placement of computer submarine' do
    comp = Computer.new
    expect(coordinates).to be_instance_of(Cell)
  end
end