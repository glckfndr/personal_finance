require "test_helper"

class OperationTest < ActiveSupport::TestCase
  test "Call get_sum_for_all_category in the first month" do
    sums = Operation.get_sum_for_all_category('2023-01-01 00:00:01', '2023-01-31 00:00:01', 'витрати')

    assert sums[0][0] =="Sport" && sums[0][1] == 1100
    assert sums[1][0] =="Bread" && sums[1][1] == 70
  end

  test "Call get_sum_for_all_category in the second month" do
    sums = Operation.get_sum_for_all_category('2023-02-01 00:00:01', '2023-02-28 00:00:01',
                                              'витрати')

    assert sums[0][0] =="Sport" && sums[0][1] == 220
    assert sums[1][0] =="Bread" && sums[1][1] == 135
  end

  test "Call get_sum_for_all_category for two month" do
    sums = Operation.get_sum_for_all_category('2023-01-01 00:00:01', '2023-02-28 00:00:01',
                                              'витрати')

    assert sums[0][0] =="Sport" && sums[0][1] == 1320
    assert sums[1][0] =="Bread" && sums[1][1] == 205
  end

  test "Call get_sum_on_dates for two month for category Sport" do
    sums_on_dates = Operation.get_sum_on_dates('2023-01-01 00:00:01', '2023-02-28 00:00:01',
                                               'витрати','Sport')

    assert sums_on_dates['2023-01-02'] == 100
    assert sums_on_dates['2023-01-12'] == 1000
    assert sums_on_dates['2023-02-03'] == 220
  end

  test "Call get_sum_on_dates for two month for All category" do
    sums_on_dates = Operation.get_sum_on_dates('2023-01-01 00:00:01', '2023-02-28 00:00:01',
                                               'витрати','All')

    assert sums_on_dates['2023-01-02'] == 125
    assert sums_on_dates['2023-01-14'] == 45
    assert sums_on_dates['2023-01-12'] == 1000

    assert sums_on_dates['2023-02-03'] == 300
    assert sums_on_dates['2023-02-24'] == 55
  end

end


