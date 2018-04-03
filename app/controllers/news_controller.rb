class NewsController < ApplicationController
  def index
    @news = Entry.order('created_at DESC')
  end

  def create
    @new = Entry.new(title: params[:title], body: params[:body], subtitle: params[:subtitle])
    if @new.save
      render json: @new, :except=>  [:updated_at] , status: :created
    else
      render json: @new.errors, status: :unprocessable_entity
    end
  end

  def show
    if Entry.exists?(id: params[:id])
      @new = Entry.find(params[:id])
    else
      render json: {"error": "Not found"}, status: 404
    end
  end

  def destroy
    if Entry.exists?(id: params[:id])
      @new = Entry.find(params[:id])
      @info = {id: @new.id, title: @new.title, subtitle: @new.subtitle, body: @new.body, created_at: @new.created_at}
      @new.destroy
      render json: @info, status: 200
    else
      render json: {"error": "Not found"}, status: 404
    end
  end

  def update_complete
    if params.key?("subtitle") and params.key?("title") and params.key?("body") and params.key?("id")
      if Entry.exists?(id: params[:id])
        @new = Entry.find(params[:id])
        @new.update_attributes({title: params[:title], subtitle: params[:subtitle], body: params[:body]})
        render json: @new, :except=>  [:updated_at] , status: 200
      else
        render json: {"error": "Not found"}, status: 404
      end
    else
      render json: {"error": "Incomplete parameters"}, status: 422
    end
  end

  def update
    if params.key?("subtitle") or params.key?("title") or params.key?("body")
      if Entry.exists?(id: params[:id])
        @new = Entry.find(params[:id])
        if params.key?("subtitle") and params.key?("title") and params.key?("body")
            @new.update_attributes({title: params[:title], subtitle: params[:subtitle], body: params[:body]})
        elsif params.key?("subtitle") and params.key?("title")
            @new.update_attributes({title: params[:title], subtitle: params[:subtitle]})
        elsif params.key?("subtitle") and params.key?("body")
            @new.update_attributes({subtitle: params[:subtitle], body: params[:body]})
        elsif params.key?("title") and params.key?("body")
            @new.update_attributes({title: params[:title], body: params[:body]})
        elsif params.key?("title")
              @new.update_attributes({title: params[:title]})
        elsif params.key?("subtitle")
              @new.update_attributes({subtitle: params[:subtitle]})
        elsif params.key?("body")
              @new.update_attributes({body: params[:body]})
        end
        render json: @new, :except=>  [:updated_at] , status: 200
      else
        render json: {"error": "Not found"}, status: 404
      end
    else
      render json: {"error": "Incomplete parameters"}, status: 422
    end
  end
end
