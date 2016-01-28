require 'test_helper'

class CreateArticlesTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.create(username: "john", email: "john@example.com", password: "password", admin: true)
  end

  test "get new articles form and create article" do
    sign_in_as(@user,"password")
    get new_article_path
    assert_template 'articles/new'
    assert_difference 'Article.count', 1 do
      post_via_redirect articles_path, article: { title: "exampletitle", description: "testdescription" }
    end
    assert_template 'articles/show'
    assert_match "exampletitle", response.body
    assert_select 'div.alert-success'
  end

  test "wrong information should give error on submission" do
    sign_in_as(@user,"password")
    get new_article_path
    assert_template 'articles/new'
    assert_no_difference 'Article.count' do
      post articles_path, article: { title: " ", description: " " }
    end
    assert_template 'articles/new'
    assert_select 'div.panel-danger'
  end

end