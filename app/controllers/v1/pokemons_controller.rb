class V1::PokemonsController < V1::BaseController
  def index
    @pokemons = Pokemon.all

    render json: @pokemons
  end
end
