class BookmarksController < ApplicationController
  # set_bookmark: runs before destroy, so we can find the bookmark we're trying to delete
  before_action :set_bookmark, only: :destroy
  # set_list: runs before new and create, to load the correct list for the form or the newly created bookmark
  before_action :set_list, only: [:new, :create]

  def new
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.list = @list
    if @bookmark.save
      redirect_to list_path(@list), notice: "Movie added to the list!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark.destroy
    redirect_to list_path(@bookmark.list), notice: "Bookmark was successfully deleted."
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:movie_id, :comment)
  end

  def set_bookmark
    @bookmark = Bookmark.find(params[:id])
  end

  def set_list
    @list = List.find(params[:list_id])
  end
end
