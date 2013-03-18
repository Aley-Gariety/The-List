class Comment < ActiveRecord::Base
  attr_accessible :body, :downvotes, :post_id, :upvotes, :user_id, :comment_type

  validate :no_styles_scripts

  def no_styles_scripts
    errors.add(:base) if ["<style>","<script>","<title>","<!--"].any? { |a| body.include? a }
  end
end
