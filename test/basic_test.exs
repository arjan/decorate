defmodule DecoratorTest.Fixture.MyDecorator do
  use Decorator.Define, some_decorator: 0

  def some_decorator(body, _context) do
    body
  end
end

defmodule DecoratorTest.Fixture.MyModule do
  use DecoratorTest.Fixture.MyDecorator

  @decorate some_decorator()
  def square(a) do
    a * a
  end

  @decorate some_decorator()
  def answer, do: 24

  @value 123
  @decorate some_decorator()
  def value123, do: @value

  @value 666
  @decorate some_decorator()
  def value666 do
    {:ok, trunc(2 * @value * 0.5)}
  end
end

defmodule DecoratorTest.Basic do
  use ExUnit.Case
  alias DecoratorTest.Fixture.MyModule

  test "basic function decoration" do
    assert 4 == MyModule.square(2)
    assert 16 == MyModule.square(4)
  end

  test "decorate function with no argument list" do
    assert 24 == MyModule.answer()
  end

  test "normal module attributes should still work" do
    assert 123 == MyModule.value123()
    assert {:ok, 666} == MyModule.value666()
  end
end
