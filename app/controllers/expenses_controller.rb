class ExpensesController < ApplicationController
  # GET /expenses
  # GET /expenses.xml
  def index
    @expenses = Expense.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @expenses }
    end
  end

  # GET /expenses/1
  # GET /expenses/1.xml
  def show
    @expense = Expense.find params[:id]

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @expense }
    end
  end

  def show_account
    @expenses = Expense.where :account_id =>  params[:id]
    @total = Expense.total @expenses

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @expenses }
    end
  end

  # GET /expenses/new
  # GET /expenses/new.xml
  def new
    @expense = Expense.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @expense }
    end
  end

  # GET /expenses/1/edit
  def edit
    @expense = Expense.find(params[:id])
  end

  # POST /expenses
  # POST /expenses.xml
  def create
    @expense = Expense.new(params[:expense])

    respond_to do |format|
      if @expense.save && Account.debit(@expense) #if account can spend and the debit is succesfully saved
        flash[:notice] = "Expense of #{@expense.amount} succesfully saved."
        format.html { redirect_to(@expense) }
        format.xml  { render :xml => @expense, :status => :created, :location => @expense }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @expense.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /expenses/1
  # PUT /expenses/1.xml
  def update
    @expense = Expense.find(params[:id])

    respond_to do |format|
      if @expense.update_attributes(params[:expense])
        format.html { redirect_to(@expense, :notice => 'Expense was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @expense.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /expenses/1
  # DELETE /expenses/1.xml
  def destroy
    @expense = Expense.find(params[:id])
    account = Account.find @expense.account
    record = Record.where(:account_id => account.id, :trans_id => @expense.id, :debit => true).first
    if !account.nil? && !@expense.nil? && !record.nil?
      account.balance += @expense.amount
      account.save
      @expense.destroy
      record.destroy
      flash[:notice] = "Expense of #{@expense.id} has been deleted and the account #{account.id} has been restored to previos balance"
    else
      flash[:notice] = "Errors: #{record.errors}, #{record.errors} "
    end
    respond_to do |format|
      format.html { redirect_to(expenses_url) }
      format.xml  { head :ok }
    end
  end
end
