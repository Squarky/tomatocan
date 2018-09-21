require 'test_helper'

#class merchpdfInterfaceTest < ActionDispatch::IntegrationTest
 class MerchandisesIntegrationTest < ActiveSupport::TestCase

  def setup
    @book = books(:one)
  end
  
  test "has a bookpdf" do
    book = books(:bookpdf)
    assert File.exists?(book.bookpdf.file.path)
  end

  test "uploads a bookpdf" do
    book = books.create!(:bookpdf, fixture_file_upload('test/files/fox.pdf', 'file/epub'))
    assert(File.exists?(merchandise.reload.merchpdf.file.path))
  end
end