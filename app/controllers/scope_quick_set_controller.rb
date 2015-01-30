class ScopeQuickSetController < ApplicationController
  # Devise protection...
  before_filter :authenticate_user!, only: [:new, :edit]

  layout 'no_sidebar_no_search'

  def index
    @quicksets = ScopeQuickSet.all
  end

  def show
    @quickset = ScopeQuickSet.find(params[:id])
  end

  def new
    @quickset = ScopeQuickSet.new
  end

  def edit
    @quickset = ScopeQuickSet.find(params[:id])
  end

  def create
    @quickset = ScopeQuickSet.new(article_params)

    if @quickset.save
      redirect_to @quickset
    else
      render 'new'
    end
  end

  def update
    @quickset = ScopeQuickSet.find(params[:id])

    if @quickset.update_attributes(params['scope_quick_set'])
      redirect_to scope_quick_set_index_path
      # redirect_to @quickset
    else
      render 'edit'
    end
  end

  def destroy
    @quickset = ScopeQuickSet.find(params[:id])
    @quickset.destroy

    redirect_to articles_path
  end


  private
    def quickset_params
      params.require(:scope_quick_set).permit(:name, :description, :suppressed, :scope_database_ids)
    end


end


