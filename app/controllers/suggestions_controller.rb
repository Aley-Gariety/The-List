class SuggestionsController < ApplicationController

  skip_before_filter :require_login, :only => [:index, :show, :recent, :top]

  @@suggestions = Suggestion
    .joins("LEFT JOIN votes ON suggestions.id = votes.post_id")
    .select("suggestions.id," +
      "sum(if(vote_type = 2, if(direction = 0, value, -value),0)) as score," +
      "sum(if(vote_type = 2, if(direction = 0, value, 0),0)) as upvotes," +
      "sum(if(vote_type = 2, if(direction = 1, -value, 0),0)) as downvotes," +
      "suggestions.created_at," +
      "text," +
      "title," +
      "suggestions.user_id")
    .group("suggestions.id")

  # GET /suggestions
  # GET /suggestions.json
  def index
    @suggestions = @@suggestions.order("log10(abs(sum(if(vote_type = 2, if(direction = 0, value, if(direction is null, 0, -value)),0))) + 1) * sign(sum(if(vote_type = 2, if(direction = 0, value, if(direction is null, 0, -value)),0))) + (unix_timestamp(suggestions.created_at) / 300000) DESC")
      .page(@page)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @suggestions }
    end
  end

  # GET /suggestions/1
  # GET /suggestions/1.json
  def show
    @suggestion = Suggestion.find(params[:id])

    @comments = Comment
      .joins("LEFT JOIN votes ON comments.id = votes.post_id")
      .select("comments.id," +
        "sum(if(vote_type = 3, if(direction = 0, value, if(direction is null, 0, -value)),0)) as score," +
        "sum(if(vote_type = 3, if(direction = 0, value, 0),0)) as upvotes," +
        "sum(if(vote_type = 3, if(direction = 1, -value, 0),0)) as downvotes," +
        "comments.created_at," +
        "body," +
        "comments.user_id")
      .where(:post_id => @suggestion.id, :comment_type => 1)
      .group("comments.id")

    @comment = Comment.new

    @suggestion = Suggestion
      .joins("LEFT JOIN votes ON suggestions.id = votes.post_id")
      .select("suggestions.id," +
        "sum(if(vote_type = 2, if(direction = 0, value, if(direction is null, 0, -value)),0)) as score," +
        "sum(if(vote_type = 2, if(direction = 0, value, 0),0)) as upvotes," +
        "sum(if(vote_type = 2, if(direction = 1, -value, 0),0)) as downvotes," +
        "suggestions.created_at," +
        "text," +
        "title," +
        "suggestions.user_id").find(params[:id])

    if current_user
      if Vote.where(:user_id => current_user.id, :post_id => @suggestion.id, :direction => 0, :vote_type => 2).count > 0
        @active = ' upactive'
      elsif Vote.where(:user_id => current_user.id, :post_id => @suggestion.id, :direction => 1, :vote_type => 2).count > 0
        @active = ' downactive'
      end

      found_vote = Vote.find_by_post_id_and_user_id_and_vote_type(@suggestion.id, current_user.id, 3)

      if found_vote
        @value = found_vote.value
      else
     	  @value = current_user.karma * 0.02
     	  @value = 1 if @value < 1
      end


      if current_user.id == @suggestion.user_id.to_i
        @active += " owner"
      end
    end


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @suggestion }
    end
  end

  # GET /suggestions/new
  # GET /suggestions/new.json
  def new
    @suggestion = Suggestion.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @suggestion }
    end
  end

  # GET /suggestions/1/edit
  def edit
    @suggestion = Suggestion.find(params[:id])
  end

  # POST /suggestions
  # POST /suggestions.json
  def create
    @suggestion = Suggestion.new(params[:suggestion].merge(:user_id => current_user.id))

    respond_to do |format|
      if @suggestion.save

   	    @new_vote = Vote.create(:post_id => @suggestion.id, :user_id => current_user.id, :vote_type => 2, :direction => 0, :value => 1)

        format.html { redirect_to @suggestion, notice: 'Suggestion was successfully created.' }
        format.json { render json: @suggestion, status: :created, location: @suggestion }
      else
        format.html { render action: "new" }
        format.json { render json: @suggestion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /suggestions/1
  # PUT /suggestions/1.json
  def update
    @suggestion = Suggestion.find(params[:id])

    respond_to do |format|
      if @suggestion.update_attributes(params[:suggestion])
        format.html { redirect_to @suggestion, notice: 'Suggestion was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @suggestion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /suggestions/1
  # DELETE /suggestions/1.json
  def destroy
    @suggestion = Suggestion.find(params[:id])
    @suggestion.destroy

    respond_to do |format|
      format.html { redirect_to suggestions_url }
      format.json { head :no_content }
    end
  end
end
