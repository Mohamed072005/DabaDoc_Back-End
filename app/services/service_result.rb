class ServiceResult
  attr_reader :success, :data, :error, :status

  def initialize(success:, data: nil, error: nil, status: nil)
    @success = success
    @data = data
    @error = error
    @status = status || (success ? :ok : :unprocessable_entity)
  end

  def success?
    @success
  end

  def self.success(data = nil, status = :ok)
    new(success: true, data: data, status: status)
  end

  def self.error(error, status = :unprocessable_entity)
    new(success: false, error: error, status: status)
  end
end