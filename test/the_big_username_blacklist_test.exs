defmodule TheBigUsernameBlacklistTest do
  use ExUnit.Case
  doctest TheBigUsernameBlacklist

  test "Returns true when string is not included in blacklist" do
    assert TheBigUsernameBlacklist.valid?("tonystark") == true
  end

  test "Returns false when string is included in blacklist" do
    assert TheBigUsernameBlacklist.valid?("logout") == false
  end

  # New keyword API tests
  test "Returns true when string is not included in extra blacklist" do
    assert TheBigUsernameBlacklist.valid?("tonystark", extra: ["about-me", "contact-us"]) == true
  end

  test "Returns false when string is included in extra blacklist" do
    assert TheBigUsernameBlacklist.valid?("about-me", extra: ["about-me", "contact-us"]) == false
  end

  test "Can use sigil for extra blacklist" do
    assert TheBigUsernameBlacklist.valid?("contact-us", extra: ~w[about-me contact-us]) == false
  end

  # Input normalization tests
  test "Handles case variations" do
    assert TheBigUsernameBlacklist.valid?("ADMIN") == false
    assert TheBigUsernameBlacklist.valid?("Admin") == false
    assert TheBigUsernameBlacklist.valid?("aDmIn") == false
  end

  test "Handles whitespace variations" do
    assert TheBigUsernameBlacklist.valid?(" admin") == false
    assert TheBigUsernameBlacklist.valid?("admin ") == false
    assert TheBigUsernameBlacklist.valid?(" admin ") == false
  end

  test "Handles case and whitespace in extra terms" do
    assert TheBigUsernameBlacklist.valid?(" CUSTOM ", extra: ["custom"]) == false
    assert TheBigUsernameBlacklist.valid?("Custom", extra: ["CUSTOM"]) == false
  end

  # Global configuration tests
  test "Uses global configuration when set" do
    # Set global config
    Application.put_env(:the_big_username_blacklist, :extra, ["global-custom"])

    # Global config should be applied
    assert TheBigUsernameBlacklist.valid?("global-custom") == false

    # Clean up
    Application.delete_env(:the_big_username_blacklist, :extra)
  end

  test "Runtime options are added to global configuration" do
    # Set global config
    Application.put_env(:the_big_username_blacklist, :extra, ["global-custom"])

    # Runtime options should be added to global config
    assert TheBigUsernameBlacklist.valid?("runtime-custom", extra: ["runtime-custom"]) == false
    assert TheBigUsernameBlacklist.valid?("global-custom", extra: ["runtime-custom"]) == false

    # Clean up
    Application.delete_env(:the_big_username_blacklist, :extra)
  end

  # Backwards compatibility tests (with deprecation warnings)
  test "Returns true when string is not included in custom blacklist (deprecated)" do
    # Capture warnings to test deprecation warning is shown
    import ExUnit.CaptureIO

    result =
      capture_io(:stderr, fn ->
        assert TheBigUsernameBlacklist.valid?("tonystark", ["about-me", "contact-us"]) == true
      end)

    assert result =~ "deprecated"
  end

  test "Returns false when string is included in custom blacklist (deprecated)" do
    import ExUnit.CaptureIO

    result =
      capture_io(:stderr, fn ->
        assert TheBigUsernameBlacklist.valid?("about-me", ["about-me", "contact-us"]) == false
      end)

    assert result =~ "deprecated"
  end

  test "Returns list of black listed usernames" do
    blacklist = TheBigUsernameBlacklist.get_blacklist()

    # Test that it's a list with expected size (542 terms in v2.0.1)
    assert is_list(blacklist)
    assert length(blacklist) == 542

    # Test that it contains some expected terms
    assert "admin" in blacklist
    assert "root" in blacklist
    assert "api" in blacklist
    assert "oauth" in blacklist
    # New in v2.0.1
    assert "graphql" in blacklist
    # New in v2.0.1
    assert "paypal" in blacklist
  end
end
