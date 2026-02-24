class SessionsController < ApplicationController
  def new
    # render login form in sessions/new.html.erb
  end

  def create
    # 1. try to find the user by email
    @user = User.find_by({ "email" => params["email"] })

    # 2. check if user exists
    if @user
      # 3. check password using BCrypt
      if @user.authenticate(params["password"])
        # set cookie
        session["user_id"] = @user["id"]

        flash["notice"] = "Welcome."
        redirect_to "/companies"
      else
        flash["notice"] = "Wrong password."
        redirect_to "/login"
      end
    else
      # 4. user does not exist
      flash["notice"] = "Invalid email or password."
      redirect_to "/login"
    end
  end

  def destroy
    # logout the user
    session["user_id"] = nil
    flash["notice"] = "Goodbye."
    redirect_to "/login"
  end
end
