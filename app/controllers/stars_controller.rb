class StarsController < ApplicationController

  include AtlassianJwtAuthentication

  # will respond with head(:unauthorized) if verification fails
  before_action only: [:show, :save] do |controller|
    controller.send(:verify_jwt, PluginKeyService::PLUGIN_KEY)
  end

  def show
    repo_name = params.permit(:repoPath)['repoPath']
    locals = {
        session_token: create_session_token
    }.merge! (Repo.number_of_stars(current_jwt_auth, repo_name))
    render :show, locals: locals
  end

  def save
    repo_name = params.permit(:repoPath)['repoPath']
    repo = Repo.find_or_initialize_by(repo_name: repo_name, jwt_token_id: current_jwt_auth.id)
    if repo.new_record?
      repo.save
      starred = true
    else
      repo.destroy
      starred = false
    end
    render json: {
        repo_name: repo_name,
        count: Repo.where(repo_name: repo_name).count,
        starred: starred
    }
  end

  private

  def create_session_token
    issued_at = Time.now.utc.to_i

    JWT.encode({
                   iss: current_jwt_auth.client_key,
                   iat: issued_at,
                   aud: [current_jwt_auth.addon_key]
               }, current_jwt_auth.shared_secret)
  end

end