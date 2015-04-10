class AmendmentsController < ApplicationController
  before_action :set_amendment, only: [:show, :edit, :update, :destroy]
  before_action :set_contracts, only: [:edit, :update, :create, :new]
  after_action :update_contract_value, only: [:create]
  after_action :update_contract_value_after_update, only: [:update]

  respond_to :html

  def index
    @amendments = Amendment.all
    respond_with(@amendments)
  end

  def show
    respond_with(@amendment)
  end

  def new
    @amendment = Amendment.new
    respond_with(@amendment)
  end

  def edit
  end

  def create
    @amendment = Amendment.new(amendment_params)
    @amendment.save
    respond_with(@amendment)
  end

  def update
    @amendment.update(amendment_params)
    respond_with(@amendment)
  end

  def destroy
    @amendment.destroy
    respond_with(@amendment)
  end

  private
    def set_amendment
      @amendment = Amendment.find(params[:id])
    end

    def amendment_params
      params.require(:amendment).permit(:contract_id, :start_date, :end_date, :value, :number, :title)
    end

    def set_contracts
      @contracts = Contract.all
    end
    
    def update_contract_current_value(contract)
      #atribuo o valor dele ao contador
      sum = contract.monthly_payment

      #procuro todos os aditamentos desse contrato e retorno um array
      amendments = Amendment.where('contract_id = ?', contract.id)

      #faço o cálculo dos aditamentos
      amendments.each { |amendment| sum += amendment.value }

      #atualizo o valor atual do contrato
      contract.update_attribute('current_value', sum)
    end

    #atualiza valor atual da tabela do contrato na criação do aditamento
    def update_contract_value
      update_contract_current_value(Contract.find(params[:amendment][:contract_id]))
    end

    def update_contract_value_after_update
       update_contract_current_value(Contract.find(params[:amendment][:contract_id]))     
    end

end