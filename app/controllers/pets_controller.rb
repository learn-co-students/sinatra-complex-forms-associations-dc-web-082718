class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
     @pet = Pet.create(params[:pet])

     if params[:owner_name] != ""
       owner = Owner.create(name: params[:owner_name])
       owner.pets << @pet
     end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do

    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end


  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end



  get '/pets/:id/update' do
    # {"pet_name"=>"Chewie Darling", "pet"=>{"owner_id"=>"1"},
     # "owner"=>{"name"=>""}, "captures"=>[], "id"=>"1"}
     @pet = Pet.find(params[:id])
     name = params["pet_name"]
     owner_id = params[:pet]["owner_id"]
     if params[:owner][:name] != ""
       # binding.pry
       owner = Owner.create(name: params[:owner][:name])
       owner_id = owner.id
     end
     # binding.pry

    @pet.update(name: name, owner_id: owner_id)
    # binding.pry
    redirect to "pets/#{@pet.id}"
  end
end
