class CommentsController < ApplicationController
  def index
    if Entry.exists?(id: params[:news_id])
      @new = Entry.find(params[:news_id])
      @comments = @new.comments.order('created_at DESC')
    else
      render json: {"error": "Not found"}, status: 404
    end
  end

  def create
    if Entry.exists?(id: params[:news_id])
      @new = Entry.find(params[:news_id])
      if params.key?("author") and params.key?("comment")
        @comment = @new.comments.new(author: params[:author], comment: params[:comment])
        if @comment.save
          render json: @comment, :except=>  [:updated_at] , status: :created
        else
          render json: @comment.errors, status: :unprocessable_entity
        end
      else
        render json: {"error": "Incomplete parameters"}, status: 422
      end
    else
      render json: {"error": "Not found"}, status: 404
    end
  end

  def show
    if Entry.exists?(id: params[:news_id])
      @new = Entry.find(params[:news_id])
      if @new.comments.exists?(id: params[:id])
        @comment = @new.comments.find(params[:id])
      else
        render json: {"error": "Not found"}, status: 404
      end
    else
      render json: {"error": "Not found"}, status: 404
    end
  end

  def destroy
    if Entry.exists?(id: params[:news_id])
      @new = Entry.find(params[:news_id])
      if @new.comments.exists?(id: params[:id])
        @comment = @new.comments.find(params[:id])
        @info = {id: @comment.id, author: @comment.author, comment: @comment.comment, created_at: @comment.created_at}
        @comment.destroy
        render json: @info, status: 200
      else
        render json: {"error": "Not found"}, status: 404
      end
    else
      render json: {"error": "Not found"}, status: 404
    end
  end

  def update_complete
    if params.key?("author") and params.key?("comment") and params.key?("id")
      if Entry.exists?(id: params[:news_id])
        @new = Entry.find(params[:news_id])
        if @new.comments.exists?(id: params[:id])
          @comment = @new.comments.find(params[:id])
          @comment.update_attributes({author: params[:author], comment: params[:comment]})
          render json: @comment, :except=>  [:updated_at] , status: 200
        else
          render json: {"error": "Not found"}, status: 404
        end
      else
        render json: {"error": "Not found"}, status: 404
      end
    else
      render json: {"error": "Incomplete parameters"}, status: 422
    end
  end

  def update
    @params = params
    if @params.key?("comment")
      if not(@params[:comment].is_a? String)
        if not(@params[:comment].key?("comment"))
          nuevo_params = @params.except(:comment)
          @params = nuevo_params
        else
          @params[:comment] = @params[:comment][:comment]
        end
      end
    end
    puts @params
    puts "ME METO ACA"
    if @params.key?("author") or @params.key?("comment")
      if Entry.exists?(id: @params[:news_id])
        @new = Entry.find(@params[:news_id])
        if @new.comments.exists?(id: @params[:id])
          @comment = @new.comments.find(@params[:id])
          if @params[:author].nil?
            if not(@params[:comment].nil?)
              @comment.update_attributes({comment: @params[:comment]})
            end
          else
            if @params[:comment].nil?
              @comment.update_attributes({author: @params[:author]})
            else
              @comment.update_attributes({comment: @params[:comment], author: @params[:author]})
            end
          end
          render json: @comment, :except=>  [:updated_at] , status: 200
        else
          render json: {"error": "Not found"}, status: 404
        end
      else
        render json: {"error": "Not found"}, status: 404
      end
    else
      render json: {"error": "Incomplete parameters"}, status: 422
    end
  end


end
