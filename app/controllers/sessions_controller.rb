class SessionsController < ApplicationController

  def new

  end

  def create
    teacher = Teacher.find_by_email(params[:email])
    student = Student.find_by_email(params[:email])
    parent = Parent.find_by_email(params[:email])

    if teacher && teacher.authenticate(params[:password]) && params[:radio_selection] == "Teacher"
      session[:user_id] = teacher.id
      session[:user_type] = "Teacher"
      redirect_to root_path, notice: "You have succesfully logged in!"
    elsif student && student.authenticate(params[:password]) && session[params[:user_type]] == "Student"
      session[:user_id] = student.id
      session[:user_type] = "Student"
      redirect_to root_path, notice: "You have succesfully logged in!"
    elsif parent && parent.authenticate(params[:password]) && session[params[:user_type]] == "Parent"
      session[:user_id] = parent.id
      session[:user_type] = "Parent"
      redirect_to root_path, notice: "You have succesfully logged in!"
    else
      flash.now[:alert] = "Login failed: invalid email or password."
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    session[:user_type] = nil
    redirect_to login_path, notice: "You have logged out."
  end

end
