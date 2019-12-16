class Book < ApplicationRecord
  validates_presence_of :title, :publication_year, :pages

  has_many :author_books
  has_many :authors, through: :author_books
end
