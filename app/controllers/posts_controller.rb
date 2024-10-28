class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy like unlike ]
  before_action :authenticate_user!, except: %i[ index show ]

  def index
    @posts = Post.all
  end

  def show; end

  def new
    @post = Post.new
  end

  def edit; end

  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Post was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to posts_path, status: :see_other, notice: "Post was successfully destroyed." }
    end
  end

  def like
    current_user.likes.create(likeable: @post)
    render partial: "posts/post", locals: { post: @post }
  end

  def unlike
    current_user.likes.find_by(likeable: @post).destroy
    render partial: "posts/post", locals: { post: @post }
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
