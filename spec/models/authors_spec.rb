require 'rails_helper'

RSpec.describe Author, type: :model do
  describe 'validations' do
    it {should validate_presence_of :name}
  end

  describe 'relationships' do
    it {should have_many :author_books}
    it {should have_many(:books).through(:author_books)}
  end

  describe 'methods' do
    it 'can calculate author average pages' do
      @david_author = Author.create!(name: 'David Barriga-Gomez')
      @foxy_book = @david_author.books.create!(title: "Foxy's Book", pages: 666, publication_year: '2014')
      @bear_book = @david_author.books.create!(title: "Bear's Book", pages: 999, publication_year: '2012')

      expect(@david_author.average_pages).to eq(0.8325e3)
    end
  end
end
