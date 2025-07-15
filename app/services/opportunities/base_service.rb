module Opportunities
  class BaseService
    def self.call(**kwargs)
      new(**kwargs).call
    end
  end
end
