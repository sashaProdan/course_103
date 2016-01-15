
class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ''

  attr_accessor :title, :description, :done

  def initialize(title, description = '')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end
end

class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end

  def size
    @todos.count
  end

  def first
    @todos.first
  end

  def last
    @todos.last
  end

  def shift
    @todos.shift
  end

  def pop
    @todos.pop
  end

  def done?
    @todos.all? { |todo| todo.done? }
  end

  def add(item)
    @todos << item
    @todos
  end

  def item_at(index)
    @todos.fetch(index)
  end

  def mark_done_at(index)
    item_at(index).done!
  end

  def mark_undone_at(index)
    item_at(index).undone!
  end

  def done!
    @todos.each_index do |index|
      mark_done_at(index)
    end
  end

  def remove_at(index)
    @todos.delete(item_at(index))
  end

  def to_s
    text = "-----#{title}----\n"
    text << @todos.map(&:to_s).join("\n")
    text
  end

  def to_a
    @todos
  end

  def each
    @todos.each do |todo|
      yield(todo)
    end
    self
  end

  def select
    list = TodoList.new(title)
    each do |todo|
      list.add(todo) if yield(todo)
    end
    list
  end

  def find_by_title(str)
    select { |todo| todo.title == str }.first
  end

  def all_done
    select { |todo| todo.done? }
  end

  def all_not_done
    select { |todo| !todo.done? }
  end

  def mark_done(title)
    find_by_title(title) && find_by_title(title).done!
  end

  def mark_all_done
    each { |todo| todo.done!}
  end

  def mark_all_undone
    each { |todo| todo.undone! }
  end
end

todo1 = Todo.new('Buy milk')
todo2 = Todo.new('Drink beer')
todo3 = Todo.new('Play tennis')
todo4 = Todo.new('Buy some presents')
todo5 = Todo.new('Go see grandma')

list = TodoList.new('Tasks for today')

list.add(todo1)
list.add(todo2)
list.add(todo3)
list.mark_done_at(1)

puts list.to_s

puts list.mark_all_done
puts list.mark_all_undone
