class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
     @owners = Owner.all
     # binding.pry
    erb :'/pets/new'
  end

  post '/pets' do
      # binding.pry
      @pet = Pet.create(params[:pet])
      # binding.pry
      unless params['owner']['name'].empty?
          # binding.pry
          @pet.owner = Owner.create(name: params['owner']['name'])
      end
      # binding.pry
      @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  patch '/pets/:id' do
      # binding.pry
      @pet = Pet.find(params[:id])
      ####### bug fix
     # binding.pry
      @pet.update(params['pet'])
      #######

      # binding.pry
      unless params['owner']['name'].empty?
          @pet.owner = Owner.create(name: params['owner']['name'])
      end
        @pet.save
      # binding.pry
    redirect to "pets/#{@pet.id}"
  end
end
