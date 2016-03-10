class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]
  before_action :logged_in?
  before_action :logged_in_as_teacher?

  # GET /students
  def index
    @students = Student.where(teacher_id: session[:user_id])
  end

  # GET /students/1
  def show
  end

  # GET /students/new
  def new
    @student = Student.new(teacher_id: session[:user_id])
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students
  def create
    @student = Student.new(student_params)

    if @student.save
      redirect_to @student, notice: 'Student was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /students/1
  def update
    if @student.update(student_params)
      redirect_to @student, notice: 'Student was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /students/1
  def destroy
    @student.destroy
    redirect_to students_url, notice: 'Student was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
      unless @student.teacher_id == session[:user_id]
        redirect_to :back
      end
    end

    # Only allow a trusted parameter "white list" through.
    def student_params
      params.require(:student).permit(:name, :email, :password, :teacher_id, :radio_selection)
    end
end
