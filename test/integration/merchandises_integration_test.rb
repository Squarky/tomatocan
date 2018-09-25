require 'test_helper'

CarrierWave.root = 'test/fixtures/files'

#class merchpdfInterfaceTest < ActionDispatch::IntegrationTest
 class MerchandisesIntegrationTest < ActiveSupport::TestCase

  
  test "has a merchpdf" do
    #merchandise = merchandises(:merchpdf)
    assert File.exists?(merchandise.merchpdf.file.path)
    #puts "generated id = #{merchandises(:merchpdf)}"
  end


end