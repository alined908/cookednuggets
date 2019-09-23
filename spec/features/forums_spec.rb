require 'spec_helper'

feature 'forum thread creation' do
  scenario 'with invalid attributes' do
    sign_in
    visit threads_path
    page.should have_css('.admin-form', :visible => true)
    fill_in 'forum_thread[subject]', :with => 'article'
    click_button 'Submit'
    expect(page).to have_current_path(threads_path)
    page.should have_css('.alert-danger', :visible => true)
  end
end

feature 'news article creation' do
  scenario 'with valid attributes' do
    sign_in
    visit threads_path(:f => "news")
    page.should have_css('.admin-form', :visible => true)
    fill_in 'new[subject]', :with => 'article'
    click_button 'Submit'
    expect(page).to have_content "Article successfully created"
  end

  scenario 'with invalid attributes' do
    sign_in
    visit threads_path(:f => "news")
    click_button 'Submit'
    expect(page).to have_current_path(threads_path(:f => "news"))
    page.should have_css('.alert-danger', :visible => true)
  end

  scenario 'featured article' do
    sign_in
    visit threads_path(:f => "news")
    fill_in 'new[subject]', :with => 'article'
    find(:css, "#new_featured").set(true)
    click_button 'Submit'
    expect(page).to have_content "Article successfully created"
    visit root_path
    expect(page).to have_css(".featured-article-title", text: "article")
  end
end

feature 'forum post creation' do
  scenario 'create thread post' do
    sign_in
    thread = create(:forum_thread)
    visit thread_path(thread)
    fill_in 'forum_post[body]', :with => 'lorem ipsum'
    click_button "Submit Post"
    expect(page).to have_content "Post successfully created."
    expect(page).to have_current_path(thread_path(thread))
    expect(page).to have_content "lorem ipsum"
  end

  scenario 'edit post' do
    sign_in
    thread = create(:forum_thread)
    post = create(:forum_post)
    visit thread_path(thread)
    expect(page).to have_content "Florida Mayhem 28-0"
    fill_in "edit-zzz1", :with => 'test'
    click_button "Edit Post"
    expect(page).to have_content "test"
    expect(page).to have_current_path(thread_path(thread))
    expect(page).to have_content "Post successfully edited."
  end

  scenario 'delete post' do
    sign_in
    thread = create(:forum_thread)
    post = create(:forum_post)
    visit thread_path(thread)
    click_link "delete"
    expect(page).to_not have_css(".parent-post")
    expect(page).to have_content "Post successfully deleted."
  end
end
