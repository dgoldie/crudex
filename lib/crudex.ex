defmodule Crudex do
  @moduledoc """
  Documentation for Crudex.
  """

  @doc false
  defmacro __using__(opts) do
    quote do
      IO.puts "In using's context (#{__MODULE__})."
      IO.puts "repo is #{unquote((opts)[:repo])}"
      # alias unquote((opts)[:repo])

      import unquote(__MODULE__)
      import Ecto.Query, warn: false
      # Module.register_attribute(__MODULE__, :repo, accumulate: true)
      # alias! (opts)[:repo]
      # IO.puts "module split is #{Module.split(unquote(opts)[:repo])}"
      # alias unquote Module.split(__CALLER__.module)
      #                 |> List.replace_at(-1, "Baz")
      #                 |> Module.concat
    end
  end

  defmacro resources(table) do
    IO.puts "In macro's context (#{__MODULE__})."
    IO.puts "table is #{ Macro.to_string table}"
    # IO.inspect "repo is #{inspect @repo}"

    # quote do
    #   alias unquote(@repo)
    # end

    quote bind_quoted: [table: table] do
      IO.puts "In caller's context (#{__MODULE__})."
      IO.puts "table is #{inspect table}"
      IO.inspect apply(table, :__schema__, [:source])
      IO.inspect Module.split table
      # IO.inspect "repo is #{inspect hd(@repo)}"




      source = apply(table, :__schema__, [:source])
      IO.puts "source is #{source}"
      single_source = table
                      |> Module.split
                      |> List.last
                      |> String.downcase
      IO.puts "single source is #{single_source}"

      # list
      list_name = String.to_atom("list_#{source}")
      def unquote(list_name)() do
        Repo.all(unquote(table))
      end

      # get
      get_name = String.to_atom("get_#{single_source}")
      def unquote(get_name)(id) do
        Repo.get(unquote(table), id)
      end

      # get!
      get_name! = String.to_atom("get_#{single_source}!")
      def unquote(get_name!)(id) do
       Repo.get!(unquote(table), id)
      end

      #create
      create_name = String.to_atom("create_#{single_source}")
      def unquote(create_name)(attrs \\ %{}) do
        unquote(table).__struct__
        |> unquote(table).changeset(attrs)
        |> Repo.insert()
      end

      #update
      update_name = String.to_atom("update_#{single_source}")
      table_struct = table.__struct__
      def unquote(update_name)(table_struct = record, attrs) do
        record
        |> unquote(table).changeset(attrs)
        |> Repo.update()
      end

      # delete
      delete_name = String.to_atom("delete_#{single_source}")
      table_struct = table.__struct__
      def unquote(delete_name)(table_struct = record) do
        Repo.delete(record)
      end

      # change
      change_name = String.to_atom("change_#{single_source}")
      table_struct = table.__struct__
      def unquote(change_name)(table_struct = record) do
        unquote(table).changeset(record, %{})
      end


    end

  end

end
