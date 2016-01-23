class CircularBuffer
  class BufferEmptyException < StandardError; end
  class BufferFullException < StandardError; end

  attr_reader :buffer, :size

  def initialize(size)
    @size = size
    @buffer = []
  end

  def read
    raise CircularBuffer::BufferEmptyException if empty?
    buffer.shift
  end

  def write(item)
    raise CircularBuffer::BufferFullException if full?
    if real_data!(item)
      buffer << item
    end
  end

  def write!(item)
    if full? && real_data!(item)
      buffer.shift
      buffer << item
    else
      buffer << item if real_data!(item)
    end
  end

  def clear
    buffer.clear
  end

  def full?
    buffer.size >= size
  end

  def empty?
    buffer.empty?
  end

  def real_data!(item)
    !item.nil?
  end
end