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
      threshold = (@@user.karma * 0.02).round

      threshold = 4 if threshold < 4
      if post.save
        new_vote = Vote.new(post_id: post.id, user_id: @@user.id, vote_type: 0, direction: 0, value: threshold)

        if new_vote.save
          User.find(@@user.id).update_attributes({
            :karma => @@user.karma - threshold
          })
        end
        present post, with: Serializers::Post
      else
        error!('409 URL exists', 409)
      end
    end
  end

end