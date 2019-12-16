require 'rails_helper'

RSpec.describe 'I visit /books', type: :feature do
  before(:each) do
    @david_author = Author.create!(name: 'David Barriga-Gomez')
    @foxy_book = @david_author.books.create!(title: "Foxy's Book", pages: 666, publication_year: '2014')
    @bear_book = @david_author.books.create!(title: "Bear's Book", pages: 999, publication_year: '2012')
  end

  it 'has a book index page. Each book with all informaiton' do
    visit '/books'
    within "#book-#{@foxy_book.id}" do
      expect(page).to have_content(@foxy_book.title)
      expect(page).to have_content(@foxy_book.pages)
      expect(page).to have_content(@foxy_book.publication_year)
      expect(page).to have_content(@david_author.name)
    end

    within "#book-#{@bear_book.id}" do
      expect(page).to have_content(@bear_book.title)
      expect(page).to have_content(@bear_book.pages)
      expect(page).to have_content(@bear_book.publication_year)
      expect(page).to have_content(@david_author.name)
    end
  end

  it 'on books index page /books author names of lnks to their page and all info about their books and average number of pages of each book they have written' do
    visit '/books'
    expect(page).to have_link(@david_author.name)

    within "#book-#{@foxy_book.id}" do
      click_on(@david_author.name)
      expect(current_path).to eq("/authors/#{@david_author.id}")
    end

      expect(page).to have_content(@david_author.name)
      expect(page).to have_content(@foxy_book.title)
      expect(page).to have_content(@bear_book.title)
      expect(page).to have_content(@david_author.average_pages)
  end
end
