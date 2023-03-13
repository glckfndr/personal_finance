# frozen_string_literal: true

require 'minitest/autorun'

class Partial_helpers_testTest < Minitest::Test
  def setup
    # Do nothing
  end

  def teardown
    # Do nothing
  end

  def test_create_table_header
    res = OperationsHelper.create_table_header(%w[a b c\ d])
    assert_equal("<tr><th><strong>a</strong></th><th><strong>b</strong></th><th><strong>c d</strong></th><tr>", res,
                 "Method create_table_header is failed!")
  end
end
