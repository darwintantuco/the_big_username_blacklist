# TheBigUsernameBlacklist
[![Build Status](https://travis-ci.org/dcrtantuco/the-big-username-blacklist.svg?branch=master)](https://travis-ci.org/dcrtantuco/the-big-username-blacklist)

This library lets you validate usernames against a blacklist. The blacklist data is based on the data from [The-Big-Username-Blacklist](https://github.com/marteinn/The-Big-Username-Blacklist) and contains privilege, programming terms, section names, financial terms and actions.

You can try the blacklist using the tool [Username checker](http://marteinn.github.io/The-Big-Username-Blacklist-JS/).

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `the_big_username_blacklist` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:the_big_username_blacklist, "~> 0.1.0"}
  ]
end
```

## Basic Usage
```elixir
iex> TheBigUsernameBlacklist.valid?("tonystark")
true
iex> TheBigUsernameBlacklist.valid?("logout")
false
```

For more info, check [https://hexdocs.pm/the_big_username_blacklist](https://hexdocs.pm/the_big_username_blacklist).

## License

MIT
