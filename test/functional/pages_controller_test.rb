require 'test_helper'

class PagesControllerTest < ActionController::TestCase

  test "should allow certain actions" do
    record = Page.new
    actions = %w(add_tags move_to_project move_to_new_project destroy)
    assert_equal controller.class.allowed_bulk_actions.sort, actions.sort
    actions.each do |action|
      if controller.respond_to?("bulk_execute_#{action}")
        assert true
      else
        assert record.respond_to?(action), "#{record.class} does not respond_to :#{action} nor is there a :bulk_execute_#{action} method in the controller"
      end
    end
  end

  test "should add tags to pages via #bulk_execute" do
    with_login do |user|
      pages = user.domain.pages
      tag_list = %w(one two three)

      assert pages.count > 1, "Not enough pages to test bulk editing"
      pages.reload.each do |page|
        assert_not_equal tag_list, page.tag_list
      end

      params = {
        :bulk => {
          :action => "add_tags",
          :add_tags => tag_list.join(", ")
        },
        :pages => pages.map(&:id).map(&:to_s)
      }
      post :bulk_execute, params

      assert_response :redirect
      pages.reload.each do |page|
        assert_equal tag_list, page.tag_list
      end
    end
  end

  test "should destroy pages via #bulk_execute" do
    with_login do |user|
      pages = user.domain.pages
      tag_list = %w(one two three)

      assert pages.count > 1, "Not enough pages to test bulk editing"

      params = {
        :bulk => {
          :action => "destroy"
        },
        :pages => pages.map(&:id).map(&:to_s)
      }
      post :bulk_execute, params

      assert_response :redirect
      pages.reload.each do |page|
        assert !Page.exists?(page), "Page should not exists after destroy"
      end
    end
  end

  test "should move pages to project via #bulk_execute" do
    with_login do |user|
      pages = user.domain.pages
      project = user.domain.projects.last

      assert pages.count > 1, "Not enough pages to test bulk editing"
      assert_not_nil project, "No project to test bulk editing"
      pages.reload.each do |page|
        assert_not_equal project.context, page.context
      end

      params = {
        :bulk => {
          :action => "move_to_project",
          :move_to_project => project.id.to_s
        },
        :pages => pages.map(&:id).map(&:to_s)
      }
      post :bulk_execute, params

      assert_response :redirect
      pages.reload.each do |page|
        assert_equal project.context, page.context
      end
    end
  end

  test "should move pages to new project via #bulk_execute" do
    with_login do |user|
      pages = user.domain.pages

      assert pages.count > 1, "Not enough pages to test bulk editing"
      pages.reload.each do |page|
        assert_nil page.context
      end

      params = {
        :bulk => {
          :action => "move_to_new_project",
          :new_project => {:title => "New Project"}
        },
        :pages => pages.map(&:id).map(&:to_s)
      }

      assert_created(Project) do
        post :bulk_execute, params
      end

      assert_response :redirect
      pages.reload.each do |page|
        assert_not_nil page.context
        assert_equal "Project", page.context.resource_type
      end
    end
  end

  test "should not move pages to new project via #bulk_execute" do
    with_login do |user|
      pages = user.domain.pages

      assert pages.count > 1, "Not enough pages to test bulk editing"
      pages.reload.each do |page|
        assert_nil page.context
      end

      params = {
        :bulk => {
          :action => "move_to_new_project",
          :new_project => {:title => ""}
        },
        :pages => pages.map(&:id).map(&:to_s)
      }

      assert_not_created(Project) do
        post :bulk_execute, params
      end

      assert_response :redirect
      pages.reload.each do |page|
        assert_nil page.context
      end
    end
  end

  test "should require login" do
    assert_login_required_for :index
  end

  test "should GET new" do
    with_login do |user|
      get :new
      assert_not_nil assigns["page"]
      assert_response :success
    end
  end

  test "should POST create" do
    with_login do |user|
      assert_created(Page) do
        params = {:page => {:title => "New page"}}
        post :create, params
        assert_response :redirect
      end
    end
  end

  test "should DELETE destroy" do
    with_login do |user|
      assert_destroyed(Page) do
        delete :destroy, :id => 1
        assert_response :redirect
      end
    end
  end

  test "should GET edit" do
    with_login do |user|
      get :edit, :id => 1
      assert_not_nil assigns["page"]
      assert_response :success
    end
  end

  test "should PUT update" do
    with_login do |user|
      hash = {:title => "New Title"}
      put :update, :id => 1, :page => hash
      assert_not_nil assigns["page"]
      hash.each do |attribute, value|
        assert_equal value, assigns["page"].send(attribute)
      end
      assert_response :redirect
    end
  end

  test "should GET show" do
    with_login do |user|
      get :show, :id => 1
      assert_not_nil assigns["page"]
      assert_response :success
    end
  end
end
