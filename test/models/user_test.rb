require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "requires a name" do
    @user = User.new(name: "", email: "john@example.com", password: "password")
    assert_not @user.valid?

    @user.name = "John"
    assert @user.valid?
  end

  test "requires a valid email" do
    @user = User.new(name: "John", email: "", password: "password")
    assert_not @user.valid?

    @user.email = "invalid"
    assert_not @user.valid?

    @user.email = "john@example.com"
    assert @user.valid?
  end

  test "requires a unique email" do
    @existing_user = User.create(
      name: "John", email: "jd@example.com", password: "password"
    )
    assert @existing_user.persisted?

    @user = User.new(name: "Jon", email: "jd@example.com")
    assert_not @user.valid?
  end

  test "name and email is stripped of spaces before saving" do
    @user = User.create(
      name: " John ", email: " John@example.com ", password: "password"
    )

    assert_equal "John", @user.name
    assert_equal "John@example.com", @user.email
  end

  test "password length must be between 8 and ActiveModel's maximum" do
    @user = User.new(
      name: "Jane",
      email: "Jane@example.com",
      password: ""
    )
    assert_not @user.valid?

    @user.password = "password"
    assert @user.valid?

    max_length = ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED + 1
    @user.password = "a" * max_length
    assert_not @user.valid?
  end
end
