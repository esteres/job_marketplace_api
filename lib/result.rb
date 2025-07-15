class Result
  attr_reader :data, :errors

  def self.success(data) = new(true, data, nil)
  def self.failure(errors) = new(false, nil, errors)

  def success? = @success
  def failure? = !@success

  private

  def initialize(success, data, errors)
    @success = success
    @data = data
    @errors = errors
  end
end
