class OperationsController < ApplicationController
  before_action :set_operation, only: %i[ show edit update destroy ]

  # GET /operations or /operations.json
  def index
    if !params[:search] || params[:search] == "" then
      @operations = Operation.order(odate: :desc, description: :asc).page params[:page]
    else
      search_name = ("%" + params[:search] + "%")
      category = Category.where("name LIKE ?", search_name).first
      #debugger
      id = category ? category.id : 0
      @operations = Operation.search_by_name_id(search_name, id).page params[:page]
    end
  end

  # GET /operations/1 or /operations/1.json
  def show
  end

  # GET /operations/new
  def new
    @categories_selected = Category.all.inject({}) {|h, x| h.merge({x.name => x.description.split(", ")}) }
    #@categories = Category.all.map{|x| [x.name, x.id]}
    @operation = Operation.new
    @operation.odate = Time.current
  end

  # GET /operations/1/edit
  def edit
    cat = Operation.find(params[:id]).category
    @categories_selected = {cat.name => cat.description.split(", ")}
    @categories = Category.all.map{|x| [x.name, x.id]}
  end

  # POST /operations or /operations.json
  def create
    @operation = Operation.new(operation_params)
    respond_to do |format|
      if @operation.save
        format.html { redirect_to operation_url(@operation), notice: "Operation was successfully created." }
        format.json { render :show, status: :created, location: @operation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @operation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /operations/1 or /operations/1.json
  def update
    respond_to do |format|
      if @operation.update(operation_params)
        format.html { redirect_to operation_url(@operation), notice: "Operation was successfully updated." }
        format.json { render :show, status: :ok, location: @operation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @operation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /operations/1 or /operations/1.json
  def destroy
    @operation.destroy
    respond_to do |format|
      format.html { redirect_to operations_url, notice: "Operation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_operation
      @operation = Operation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def operation_params
      params.require(:operation).permit(:amount, :odate, :description, :category_id, :operation_type)
    end
end
