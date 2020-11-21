class PostsController < ApplicationController

	def index
			@posts = Post.all
			@comment = Comment.new
	end

	def show
			@post = Post.find(params[:id])
			@comment = Comment.new
			#新着順で表示
			@comments = @post.comments.order(created_at: :desc)
	end

	def create
			@post = Post.new(post_params)
			@post.user_id = current_user.id
			if  @post.save
			    tags = Vision.get_image_data(@post.image)
			    tags.each do |tag|
			      @post.tags.create(name: tag)
			    end
				  redirect_to posts_path, notice: "You have created book successfully."
			else
					@posts = Post.all
					redirect_to posts_path
			end
	end

	def edit
      @post = Post.find(params[:id])
	end

	def update
      @post = Post.find(params[:id])
      if  @post.update(post_params)
      	  tags = Vision.get_image_data(@post.image)
			    tags.each do |tag|
			   	  @post.tags.update(name: tag)
			    end
          redirect_to user_path(current_user), notice: "You have updated user successfully."
      else
          render "show"
		  end
	end

	def destroy
	    @post = Post.find(params[:id])
	    @post.destroy
	    redirect_to user_path(current_user)
	end

	private

	def post_params
      params.require(:post).permit(:image,:post_comment)
	end
end
