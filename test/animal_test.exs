defmodule MreInheritTest do
  use ExUnit.Case

  test "cat" do
    IO.puts(Cat)
    {:ok, _} = Cat.start_link()
    Animal.start_running(Cat)
    IO.inspect(Animal.get_state(Cat))
    Cat.start_meowing()
    Animal.stop_running(Cat)
    Cat.start_meowing()
    IO.inspect(Animal.get_state(Cat))
    Cat.stop_meowing()
    IO.inspect(Animal.get_state(Cat))
  end

  @tag :current
  test "dog" do
    IO.puts(Dog)
    {:ok, _} = Dog.start_link()
    Animal.start_running(Dog)
    IO.inspect(Animal.get_state(Dog))
    Dog.start_barking()
    IO.inspect(Animal.get_state(Dog))
    Dog.stop_barking()
    IO.inspect(Animal.get_state(Dog))
  end
end
