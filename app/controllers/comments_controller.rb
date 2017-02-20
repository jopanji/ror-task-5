class CommentsController < ApplicationController
  def index
    @comment = Comment.all
  end

  def new
    @comment = Comment.new
  end

  def create
    @article = Article.find(params[:article_id])
    @comment = Comments.build(params[:comment])
    @comment.article_id = @article.id
    if @comment.save
      flash[:success] = "Comment created!"
      redirect_to '/contact'
    else
      render '/about'
    end
  end

  def edit
  end
end
