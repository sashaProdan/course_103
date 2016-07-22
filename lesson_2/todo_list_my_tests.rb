require 'simplecov'
SimpleCov.start

require 'minitest/autorun'

require_relative 'todo_list'

class TodoListTest < MiniTest::Test

  def setup
    @todo1 = Todo.new("Buy milk")
    @todo2 = Todo.new("Clean room")
    @todo3 = Todo.new("Go to gym")
    @todos = [@todo1, @todo2, @todo3]

    @list = TodoList.new("Today's Todos")
    @list.add(@todo1)
    @list.add(@todo2)
    @list.add(@todo3)

  end

  def test_to_a
    assert_equal(@todos, @list.to_a)
  end

  def test_size
    assert_equal(3, @list.size)

    @list.remove_at(1)
    assert_equal(2, @list.size)
  end

  def test_first_todo
    assert_equal(@todo1, @list.first)
  end

  def test_last_todo
    assert_equal(@todo3, @list.last)
  end

  def test_shift_todo
    assert_equal(@todo1, @list.shift)
  end

  def test_list_size_after_shift
    @list.shift
    assert_equal(2, @list.size)
  end

  def test_pop_todo
    assert_equal(@todo3, @list.pop)
  end

  def test_list_size_after_pop
    @list.pop
    assert_equal(2, @list.size)
  end

  def test_all_todos_done
    @list.done!
    assert_equal(true, @list.done?)

    @list.each { |t| t.undone!}
    assert_equal(false, @list.done?)
  end
  
  def test_not_todo_object
    assert_raises(TypeError) { @list << 6 }
    assert_raises(TypeError) { @list << [1, 2, 3] }
    assert_raises(TypeError) {@list << "hello" }
  end

  def test_add_showel
    todo4 = Todo.new("Greet the parents")
    todos = @todos << todo4
    assert_equal([@todo1, @todo2, @todo3, todo4], todos)
  end

  def test_alias_method_add
    todo = Todo.new('Read the book')
    @list.add(todo)
    assert_equal(todo, @list.last)
  end

  def test_item_at
    assert_equal(@todo3, @list.item_at(2))
    assert_raises(IndexError) { @list.item_at(30) }
  end

  def test_mark_done_at_index_error
    assert_raises(IndexError) { @list.mark_done_at(30) }
    @list.mark_done_at(2)
    assert_equal(true, @todo3.done?)
  end

  def test_mark_undone_at
    assert_raises(IndexError) { @list.mark_undone_at(30) }

    @todo1.done!
    @todo2.done!
    @todo3.done!

    @list.mark_undone_at(1)

    assert_equal(true, @todo1.done?)
    assert_equal(false, @todo2.done?)
  end

  def test_make_all_todos_done
    @list.done!
    assert_equal(true, @list.done?)
  end

  def test_remove_at
    todo = @list.remove_at(2)
    assert_equal(@todo3, todo)
  end

  def test_remove_at_final_list
    @list.remove_at(0)
    assert_equal(2, @list.size)
  end

  def test_index_error_remove_at
    assert_raises(IndexError) { @list.remove_at(30) }
  end

  def test_to_s
    output = <<-OUTPUT.chomp.gsub /^\s+/, ""
    ---- Today's Todos ----
    [ ] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT

    assert_equal(output, @list.to_s)
  end

  def test_list_view_after_all_todos_marked_done
    output = <<-OUTPUT.chomp.gsub /^\s+/, ""
    ---- Today's Todos ----
    [X] Buy milk
    [X] Clean room
    [X] Go to gym
    OUTPUT
    @list.done!
    assert_equal(output, @list.to_s)
  end

  def test_each_returns_original_object
    assert_equal(@list, @list.each {|t| t.title + "!"})
  end

  def test_each_should_iterate
    output = <<-OUTPUT.chomp.gsub /^\s+/, ""
    ---- Today's Todos ----
    [X] Buy milk
    [X] Clean room
    [X] Go to gym
    OUTPUT
    @list.each {|t| t.done!}
    assert_equal(output, @list.to_s)
  end

  def test_select
    @todo1.done!
    new_list = @list.select {|t| t.done?}
    assert_instance_of(TodoList, new_list)
  end
end