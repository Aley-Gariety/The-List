module Serializers
  class Post < Grape::Entity
    expose :created_at, :url, :title
  end
end

class API < Grape::API

  format :json
  def self.authenticate!
    http_basic do |email, password|
    @@user = User.authenticate(email, password)
    end
  end

  resource :posts do
    authenticate!
    desc "Create a new post."
    params do
      requires :url,   type: String
      requires :title, type: String
    end
    post do
      post = Post.new(url: params[:url], title: params[:title], user_id: @@user.id)
      if post.save
        present post, with: Serializers::Post
      else
        error!('409 URL exists', 409)
      end
    end
  end

end