defmodule QueueTest do
  use ExUnit.Case

  use GenServer

  alias Queue

  describe "enqueue/2" do
    setup do
      {:ok, pid} = Queue.start_link([1, 2, 3])

      {:ok, pid: pid}
    end

    test "should add an element to the end of the queue", %{pid: pid} do
      response = Queue.enqueue(pid, 5)

      expected_response = :ok

      assert response == expected_response
    end
  end

  describe "dequeue/1" do
    test "when the state is empty, should return a nil" do
      {:ok, pid} = Queue.start_link([])

      response = Queue.dequeue(pid)

      expected_response = nil

      assert response == expected_response
    end

    test "when state is a list, should return dequeue the last element" do
      {:ok, pid} = Queue.start_link([1, 2, 3])

      Queue.dequeue(pid)
      Queue.dequeue(pid)

      response = Queue.dequeue(pid)

      expected_response = 3

      assert response == expected_response
    end
  end
end
