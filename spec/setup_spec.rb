require 'spec_helper'

RSpec.describe Setup do
    it 'initializes' do
        setup = Setup.new
        user_board = Board.new
        comp_board = Board.new
        expect(setup).to be_instance_of(Setup)
        expect(user_board).to be_instance_of(Board)
        expect(comp_board).to be_instance_of(Board)
    end

    it 'start method creates a main menu' do
        setup = Setup.new
    end
end