class AccountsController < ApplicationController

  before_action :load_account_instance, only: [:show, :edit, :update, :destroy]
  def index
  end

  def show
    # @account = Account.where(id: params[:id])[0]
  end

  def edit
    # @account = Account.where(id: params[:id])[0]
  end

  def update
    # @account = Account.where(id: params[:id])[0]

    if @account.update(permitted_params)
      respond_to do |format|
        format.turbo_stream { flash.now[:notice] = 'Account updated succesfully.'}
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def new
    @account = Account.new
  end

  def create
    @account = Account.new(permitted_params)
    if @account.save
      respond_to do |format|
        format.html { redirect_to root_path, notice: 'Account created succesfully.' }
        format.turbo_stream { flash.now[:notice] = 'Account created succesfully.'}
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    # @account = Account.where(id: params[:id])[0]

    respond_to do |format|
      if @account.destroy
        format.turbo_stream do
          flash.now[:notice] = 'Account has been deleted succesfully'
        end
      else
        format.turbo_stream { flash.now[:alert] = 'Account is not deleted' }
      end
    end
  end

  def vat_search
    vat = Account.valvat(params[:id])

    if vat
      @name = vat[:name].split('||').first
      @area = vat[:address].split('-').last

      address_with_zip = vat[:address].split('-').first
      @zipcode = address_with_zip.split.last

      address_array = address_with_zip.split
      address_array.pop
      @address = address_array.join(' ')
    end


    respond_to do |format|
      if vat
        format.turbo_stream { flash.now[:notice] = 'VAT was succesfully retrieved.'}
      else
        format.turbo_stream { flash.now[:alert] = 'VAT is not valid.'}
      end
    end

  end

  private
  def permitted_params
    params.require(:account).permit(:vat, :name, :city, :zipcode, :address)
  end

  def load_account_instance
    @account = Account.where(id: params[:id])[0]
    if @account.nil?
      redirect_to root_path, alert: 'This account doesn\'t exist.'
    else
      @account
    end
  end
end
