require 'test_helper'

class UrlExamplesControllerTest < ActionController::TestCase
  setup do
    @url_example = url_examples(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:url_examples)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create url_example" do
    assert_difference('UrlExample.count') do
      post :create, url_example: { customAlias: @url_example.customAlias, longUrl: @url_example.longUrl, qtdAcesso: @url_example.qtdAcesso, shortUrl: @url_example.shortUrl }
    end

    assert_redirected_to url_example_path(assigns(:url_example))
  end

  test "should show url_example" do
    get :show, id: @url_example
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @url_example
    assert_response :success
  end

  test "should update url_example" do
    patch :update, id: @url_example, url_example: { customAlias: @url_example.customAlias, longUrl: @url_example.longUrl, qtdAcesso: @url_example.qtdAcesso, shortUrl: @url_example.shortUrl }
    assert_redirected_to url_example_path(assigns(:url_example))
  end

  test "should destroy url_example" do
    assert_difference('UrlExample.count', -1) do
      delete :destroy, id: @url_example
    end

    assert_redirected_to url_examples_path
  end
end
