# coding: utf-8

require 'spec_helper'

describe "mainコントローラ" do
  describe "ホーム画面タイトル" do
    it "ページ中央の文字" do
      visit '/main/home'
      page.should have_content('WCorkBoard')
    end
  end
end
