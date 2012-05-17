require 'test_helper'

class PageCanvasControllerTest < ActionController::TestCase
  setup do
    @page_canva = page_canvas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:page_canvas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create page_canva" do
    assert_difference('PageCanva.count') do
      post :create, page_canva: @page_canva.attributes
    end

    assert_redirected_to page_canva_path(assigns(:page_canva))
  end

  test "should show page_canva" do
    get :show, id: @page_canva
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @page_canva
    assert_response :success
  end

  test "should update page_canva" do
    put :update, id: @page_canva, page_canva: @page_canva.attributes
    assert_redirected_to page_canva_path(assigns(:page_canva))
  end

  test "should destroy page_canva" do
    assert_difference('PageCanva.count', -1) do
      delete :destroy, id: @page_canva
    end

    assert_redirected_to page_canvas_path
  end
end
