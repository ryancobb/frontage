class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :run]
  before_action :authenticate!

  def show
    @user = User.find(current_user)
    initialize_notifications(@user)
  end

  def update
    respond_to do |format|
      if @user.update!(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { redirect_to @user }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def initialize_notifications(user)
      TestSuite.all.each do |test_suite|
        user.notifications.where(:test_suite_id => test_suite.id).first_or_initialize
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(current_user)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(notification_profile_attributes: [:id, :slack_enabled, :slack, :email_enabled, :email, :sms_enabled, :sms], notifications_attributes: [:id, :slack, :email, :sms, :test_suite_id])
    end
end
