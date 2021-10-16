module Api
  class HelloController < ApplicationController
    def index
      render json: 'Hello Rails'
    end
  end
end
