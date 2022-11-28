class ToysController < ApplicationController
  wrap_parameters format: []

  def index
    toys = Toy.all
    render json: toys
  end

  #added show method and route to access every toy by id
  def show
    toy = find_toy_by_id
    if toy
      render json: toy
    else
      render_toy_not_found
    end
  end

  def create
    #fixed spelling error: Toy to toys
    toy = Toy.create(toy_params)
    render json: toy, status: :created
  end

  def update
    toy = find_toy_by_id
    if toy
      toy.update(toy_params)
      render json: toy
    else
      render_toy_not_found
    end
  end

  def destroy
    toy = find_toy_by_id
    if toy
      toy.destroy
      head :no_content
    else
      render_toy_not_found
    end
  end

  private
  
  def toy_params
    params.permit(:name, :image, :likes)
  end

  #implemented DRY by creating repeatable code
  def find_toy_by_id
    Toy.find_by(id: params[:id])
  end

  #displaying not-found error
  def render_toy_not_found
    render json: {error: "Toy not found"}, status: :not_found
  end

end
