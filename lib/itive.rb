class Itive
  def initialize
    @data = {}
  end

  def data(datum)
    @data[datum] = [] unless @data[datum]
    @data[datum] << Time.now
  end

  def data?(datum, timestamp = Time.now)
    return 0 unless @data[datum]
    @data[datum].select { |t| t <= timestamp }.count
  end
end
