class OwnersController < ApplicationController



    get '/owners' do
        @owners = Owner.all
        erb :'/owners/index'
    end

    get '/owners/new' do
        @pets = Pet.all
        erb :'/owners/new'
    end

    post '/owners' do
        @owner = Owner.create(params[:owner])
        unless params['pet']['name'].empty?
            @owner.pets << Pet.create(name: params['pet']['name'])
        end
        @owner.save
        redirect "owners/#{@owner.id}"
    end

    get '/owners/:id/edit' do
        @owner = Owner.find(params[:id])
        @pets = Pet.all
        # binding.pry
        erb :'/owners/edit'
    end

    get '/owners/:id' do
        # binding.pry
        @owner = Owner.find(params[:id])
        erb :'/owners/show'
    end

    patch '/owners/:id' do
        # binding.pry
        @owner = Owner.find(params[:id])
        ####### bug fix
        params[:owner]['pet_ids'] = [] unless params[:owner].key?('pet_ids')
        #######

        @owner.update(params['owner'])
        unless params['pet']['name'].empty?
            @owner.pets << Pet.create(name: params['pet']['name'])
        end
        @owner.save
        # binding.pry
        redirect "owners/#{@owner.id}"
    end
end
