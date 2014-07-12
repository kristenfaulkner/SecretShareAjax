class SecretsController < ApplicationController
  def create
    secret = Secret.new(secret_params)
    secret.author = current_user
    secret.recipient = User.find(params[:user_id])
    if secret.save
      render json: secret
    else
      flash[:errors] = secret.errors.full_messages
      render json: flash[:errors], status: 422
    end
  end
  
  def destroy
    Secret.find(params[:id]).destroy
    render json: params[:id]
  end
  
  private
  def secret_params
    params.require(:secret).permit(:title, :body);
  end
end
