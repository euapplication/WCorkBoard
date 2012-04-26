# coding: utf-8
require 'spec_helper'

describe User do
  before do
    @user = User.new(name: "テスト", email: "test@example.com", password: "foobar", password_confirmation: "foobar")
  end

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }

  it { should_not be_valid }

  describe "名前が入力されていないとき" do
    before { @user.name = "" }
    it { should_not be_valid }
  end

  describe "メールアドレスが入力されていないとき" do
    before { @user.email = "" }
    it { should_not be_valid }
  end

  describe "名前が長過ぎるとき" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "パスワードが短すぎるとき" do
    before { @user.password = "a" * 5 }
    it { should_not be_valid }
  end

  describe "メールアドレスがフォーマットと一致しないとき" do
    it "エラーをしっかり吐く" do
      addresses = %w[user@foo.com A_USER@f.b.org forst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end
    end
  end

  describe "既に登録されているメールアドレスが入力された" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save #試しにDBに登録してみる
    end

    it { should_not be_valid }
  end

  describe "パスワードが入力されなかったとき" do
    before do
      @user.password = ""
      @user.password_confirmation = ""
    end

    it { should_not be_valid }
  end

  describe "パスワードとパスワード確認欄に入力された文字列が一致しなかったとき" do
    before do
      @user.password = "test_strings_test"
      @user.password_confirmation = "test_string"
    end

    it { should_not be_valid }
  end

  describe "パスワード確認欄のみ空欄であった場合" do
    before do
      @user.password = "test_pass"
      @user.password_confirmation = ""
    end

    it { should_not be_valid }
  end

  describe "authenticateメソッドの戻り値テスト" do
    before { @user.save }

    let(:found_user) { User.find_by_email(@user.email) } #メモ化

    describe "パスワードが無効であった場合" do
      let(:user_for_invalid_password) { found_user.authenticate("foo_bar") }

      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }
    end
  end
end
