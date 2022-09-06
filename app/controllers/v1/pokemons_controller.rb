class V1::PokemonsController < V1::BaseController
  def index
    @pokemons = Pokemon.all

    render json: @pokemons
  end

  def show


  end

  def create


  end

  def update


  end

  def destroy


  end
end
