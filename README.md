# TheBigUsernameBlacklist

![Elixir CI](https://github.com/darwintantuco/the_big_username_blacklist/workflows/Elixir%20CI/badge.svg)

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

## Configuration

### Option 1: Global Configuration (Recommended)

Configure global extensions in your config file:

```elixir
# config/config.exs
config :the_big_username_blacklist,
  extra: ~w[about-me contact-us myapp-admin]
```

These will be applied to all validation calls:

```elixir
# Will automatically use your global config
iex> TheBigUsernameBlacklist.valid?("about-me")
false

iex> TheBigUsernameBlacklist.valid?("tonystark")
true
```

### Option 2: Runtime Options

You can also extend the blacklist per-call using the `:extra` option:

```elixir
# Add custom blacklisted terms
iex> TheBigUsernameBlacklist.valid?("about-me", extra: ["about-me", "contact-us"])
false

# Using sigil for cleaner syntax
iex> TheBigUsernameBlacklist.valid?("contact-us", extra: ~w[about-me contact-us])
false

iex> TheBigUsernameBlacklist.valid?("brucewayne", extra: ~w[about-me contact-us])
true
```

Runtime options are combined with global configuration.

### Migration from v0.1.x

The old API still works but shows a deprecation warning:

```elixir
# Deprecated (shows warning)
iex> TheBigUsernameBlacklist.valid?("about-me", ["about-me", "contact-us"])
false

# Preferred
iex> TheBigUsernameBlacklist.valid?("about-me", extra: ["about-me", "contact-us"])
false
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
