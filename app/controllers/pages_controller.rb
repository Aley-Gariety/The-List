class PagesController < ApplicationController

  skip_before_filter :require_login

  def guidelines
  end

  def docs
  end

  def stats
  end
end