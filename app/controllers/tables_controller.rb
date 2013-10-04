class TablesController < ApplicationController

  before_filter :upload_csv, only: :index

  def index
    @tables = Table.where(show: true).order('id DESC')
  end

  def search
    @items = Item.search(params[:search], params[:id])
    if params[:save]
      Table.create_sub_table(@items)
      redirect_to root_path
    end
  end

  private

  def upload_csv
    Table.create_from_csv(params[:csv]) if params[:csv]
  end

end
