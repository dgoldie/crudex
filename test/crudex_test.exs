defmodule CrudexTest do
  import Ecto.Schema

  defmodule Repo do
    def start_link(_opts) do
      # assert opts[:pool_size] == 1
      Process.get(:start_link)
    end

    def __adapter__ do
      Ecto.TestAdapter
    end

    def config do
      [priv: Process.get(:priv), otp_app: :ecto]
    end
  end

  defmodule Post do
    use Ecto.Schema

    schema "posts" do
      field :title, :string
    end
  end

  defmodule Sample do
    use Crudex
    resources Post
  end

  use ExUnit.Case, async: true
  doctest Crudex

  setup _context do
    {:ok,
      [crud: ~w(list_posts get_post get_post! create_post update_post delete_post)a,
      functions: Sample.__info__(:functions)]
    }
  end

  describe "test crudex resources" do

    test "Context has all functions are generated", context do
      for func <- context[:crud] do
        context[:functions]
        |> Keyword.has_key?(func)
        |> assert
      end
    end
  end
end
