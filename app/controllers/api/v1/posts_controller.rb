class Api::V1::PostsController < ApiController
  def index
    @posts = Article.all
    render json: {
      data: @posts
    }
  end
  def show
    @post = Article.find_by(id: params[:id])
    if !@post
      render json: {
        message: "Can't find the post!",
        status: 400
      }
    else
      render json: {
        title: @post.title,
        date: @post.created_at,
        description: @post.description
      }
    end
  end
  def create
    @post = Article.new(post_params)
    if @post.save
      render json: {
        message: "Post created successfully!",
        result: @post
      }
    else
      render json: {
        errors: @post.errors
      }
    end
  end
  
  def update
    @post = Article.find_by(id: params[:id])
    if @post.update(post_params)
      render json: {
        message: "Post updated successfully!",
        result: @post
      }
    else
      render json: {
        errors: @post.errors
      }
    end
  end

  def destroy
    @post = Article.find_by(id: params[:id])
    @post.destroy
    render json: {
      message: "Post destroy successfully!"
    }
  end

  private

  def post_params
    params.permit(:title, :date, :description, :file_location)
  end
end
