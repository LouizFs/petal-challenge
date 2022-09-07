require 'rails_helper'

RSpec.describe Pokemon, type: :model do
  describe '#validations' do
    it 'should validate the presence of the name' do
      name = build :pokemon, name: ''
      expect(name).not_to be_valid
      expect(name.errors.messages[:name]).to include("can't be blank")
    end
  end

  describe "#scopes" do
    before do
      Pokemon.destroy_all
    end
    describe '.filter_by_name' do
      it 'should list pokemons by name' do
        pikachu = create :pokemon, name: "pikachu"
        other_pokemon = create :pokemon, name: "teste"
        
        expect(described_class.filter_by_name("pikachu")).to match_array(
          [ pikachu ]
        )
      end
    end
  end
end
