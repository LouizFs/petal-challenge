class V1::PokemonsController < V1::BaseController
  before_action :authenticate
  before_action :find_pokemon, only: %i(show update destroy)

  def index
    @pokemons = Pokemon.filter(permitted_filters).page(params[:page])

    render json: @pokemons
  end

  def show
    render json: @pokemon
  end

  def create
    @pokemon = Pokemon.new(pokemon_params)

    if @pokemon.save
      render json: @pokemon, status: 201
    else
      render json: { error: @pokemon.errors.full_messages }, status: 422
    end
  end

  def update
    if @pokemon.update(pokemon_params)
      render json: @pokemon, status: 200
    else
      render json: { error: @pokemon.errors.full_messages }, status: 422
    end
  end

  def destroy
    @pokemon.destroy
      
    head :no_content
  end

  private

  def permitted_filters
    params.slice(:name)
  end

  def pokemon_params
    params.require(:pokemon).permit(:name, :type_1, :type_2, :total, :hp, :attack, :defense, :sp_atk, :sp_def, :speed, :generation, :legendary)
  end

  def find_pokemon
    @pokemon = Pokemon.find(params[:id])
  end

end
