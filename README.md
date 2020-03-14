# TheBigUsernameBlacklist
[![Build Status](https://travis-ci.org/darwintantuco/the-big-username-blacklist.svg?branch=master)](https://travis-ci.org/darwintantuco/the-big-username-blacklist)

This library lets you validate usernames against a blacklist. The blacklist data is based on the data from [The-Big-Username-Blacklist](https://github.com/marteinn/The-Big-Username-Blacklist) and contains privilege, programming terms, section names, financial terms and actions.

You can try the blacklist using the tool [Username checker](http://marteinn.github.io/The-Big-Username-Blacklist-JS/).

## Installation

The package can be installed by adding `the_big_username_blacklist` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:the_big_username_blacklist, "~> 0.1.2"}
  ]
end
```

## Usage
```elixir
iex> TheBigUsernameBlacklist.valid?("tonystark")
true

iex> TheBigUsernameBlacklist.valid?("logout")
false
```

### Extending blacklist

This is useful when there are existing routes or reserved words that you don't want to be a valid username.

```elixir
iex> custom_blacklist = ["about-me", "contact-us"]

iex> TheBigUsernameBlacklist.valid?("about-me", custom_blacklist)
false

iex> TheBigUsernameBlacklist.valid?("brucewayne", custom_blacklist)
true
```

### With Ecto

```elixir
def create_user_changeset(%User{} = user, attrs \\ %{}) do
  user
  |> user_changeset(attrs)
  |> validate_required([:email, :username, :first_name, :last_name])
  |> validate_username()
end

defp validate_username(%{changes: %{username: username}} = changeset) do
  if TheBigUsernameBlacklist.valid?(username) do
    changeset
  else
    add_error(changeset, :username, "Invalid username.")
  end
end

defp validate_username(changeset), do: changeset
```

For more info, check [https://hexdocs.pm/the_big_username_blacklist](https://hexdocs.pm/the_big_username_blacklist).

## Other packages
[The-Big-Username-Blacklist](https://github.com/marteinn/The-Big-Username-Blacklist) has been ported to different languages

- [python](https://github.com/marteinn/the-big-username-blacklist-python)
- [node](https://github.com/marteinn/the-big-username-blacklist-js)
- [ruby](https://github.com/unlearned/the_big_username_blacklist)

## License

MIT
