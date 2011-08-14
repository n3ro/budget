class IncomesController < ApplicationController
  # GET /incomes
  # GET /incomes.xml
  def index
    @incomes = Income.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @incomes }
    end
  end

  # GET /incomes/1
  # GET /incomes/1.xml
  def show
    @income = Income.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @income }
    end
  end

  # GET /incomes/new
  # GET /incomes/new.xml
  def new
    @income = Income.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @income }
    end
  end

  # GET /incomes/1/edit
  def edit
    @income = Income.find(params[:id])
  end

  # POST /incomes
  # POST /incomes.xml
  def create
    @income = Income.new(params[:income])

    respond_to do |format|
      if @income.save && Account.credit(@income) #if account can spend and the debit is succesfully saved
        flash[:notice] = "Income of #{@income.amount} succesfully saved."
        format.html { redirect_to(@income) }
        format.xml  { render :xml => @income, :status => :created, :location => @income }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @income.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /incomes/1
  # PUT /incomes/1.xml
  def update
    @income = Income.find(params[:id])

    respond_to do |format|
      if @income.update_attributes(params[:income])
        format.html { redirect_to(@income, :notice => 'Income was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @income.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /incomes/1
  # DELETE /incomes/1.xml
  def destroy
    @income = Income.find(params[:id])
    account = Account.find @income.account
    record = Record.where(:account_id => account.id, :trans_id => @income.id, :debit => false).first
    if !account.nil? && !@income.nil? && !record.nil?
      account.balance -= @income.amount
      account.save
      @income.destroy
      record.destroy
      flash[:notice] = "Income of #{@income.id} has been deleted and the account #{account.id} has been restored to previos balance"
    else
      flash[:notice] = "Errors: #{record.errors}, #{record.errors} "
    end
    respond_to do |format|
      format.html { redirect_to(incomes_url) }
      format.xml  { head :ok }
    end
  end
end
