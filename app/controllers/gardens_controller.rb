	class GardensController < ApplicationController
	before_action :set_garden, only: [:show, :edit, :update, :destroy]
	before_action :is_owner, except: [:new, :create, :index]

	def new
		@garden = Garden.new
	end

	def create
		@garden = Garden.new(garden_params)
		@garden.user = current_user

		if @garden.save

			redirect_to garden_path(@garden)
		else

			render :new
		end
	end

	def edit
	end

	def update
		@garden.update(garden_params)

		redirect_to @garden
	end

	def show
	end

	def destroy
		@garden.garden_plants.destroy_all
		@garden.destroy

		redirect_to root_path
	end

	def index
		@gardens = current_user.gardens

		# flash[:notice] = "There "
		# 	redirect_to 
			# @gardens = Garden.all
		# end
	end

	private

	def set_garden
		@garden = Garden.find(params[:id])
	end

	def is_owner
		unless @garden.user == current_user
			flash[:notice] = "You Do Not Have Permissions to View/Update This Garden"
			redirect_to root_path
		end
	end

	def garden_params
		params.require(:garden).permit(:name)
	end

end
