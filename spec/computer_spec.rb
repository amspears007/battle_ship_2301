require 'spec_helper'

RSpec.describe Computer do
  it 'initializes' do
    comp = Computer.new
    expect(comp).to be_instance_of(Computer)
  end

end