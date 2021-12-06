module Interactors
  class Base
    def initialize(repository)
      @repository = repository
    end

    def call
      raise NotImplementedError
    end
  end
end