# frozen_string_literal: true

class Client::LandingController < ApplicationController
  layout 'client'

  before_action :authenticate_client!

  def index; end
end
