class ServicesController < ApplicationController
  before_action :set_service, only: [:show, :edit, :update, :destroy]
  before_action :set_types, only: [:new, :edit]
  before_action :authenticate_user!
  before_action :require_admin!

  respond_to :html

  def index
    @services = Service.all
    respond_with(@services)
  end

  def show
    respond_with(@service)
  end

  def new
    @service = Service.new
    respond_with(@service)
  end

  def edit
  end

  def create
    @service = Service.new(service_params)
    @service.save
    respond_with(@service)
  end

  def update
    @service.update(service_params)
    respond_with(@service)
  end

  def destroy
    @service.destroy
    respond_with(@service)
  end

  private
    def set_service
      @service = Service.find(params[:id])
    end

    def service_params
      params.require(:service).permit(:name, :description, :category, :contract_type_id)
    end

    def set_types
      @types = ContractType.all
    end

    def require_admin!
      redirect_to root_path unless can? :manage, @services
    end
end