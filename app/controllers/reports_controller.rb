class ReportsController < ApplicationController
  def index
    @categories = Category.get_all_names
  end

  def create_report
    start_date = get_date(params, "start")
    end_date = get_date(params, "end")
    operation_type = params['operation']['operation_type']
    category_name = params['category_id']

    if params[:btn] == "pie"
      redirect_to action: 'report_by_category', start_date: start_date, end_date: end_date, operation_type: operation_type
    elsif params[:btn] == "line"
      redirect_to action: 'report_by_dates', start_date: start_date, end_date: end_date,
                  operation_type: operation_type, category_name: category_name
    else
      redirect_to action: 'report_by_dates', start_date: start_date, end_date: end_date,
                  operation_type: operation_type, category_name: "All"
    end
  end

  def report_by_category
    @start_date = params[:start_date]
    @end_date = params[:end_date]
    @operation_type = params[:operation_type]
    # debugger
    #@start_date = '2023-01-01'
    #@end_date = '2023-03-01'
    @data = Operation.get_sum_for_all_category @start_date, @end_date, @operation_type
    @xdata, @ydata = get_plot_data @data
  end

  def report_by_dates
    # categories = Category.get_all_names
    @start_date = params[:start_date]
    @operation_type = params[:operation_type]
    @end_date = params[:end_date]
    @category_name = params[:category_name]
    @data = Operation.get_sum_on_dates @start_date, @end_date, @operation_type, @category_name
    @xdata, @ydata = get_plot_data @data
    @xdata.map! { |x| x.to_date.strftime('%Y-%m-%d') }
    #.map{|x| x.attributes}
  end

  private

  def get_plot_data data
    xdata = []
    ydata = []
    data.each do |x|
      xdata.append x[0]
      ydata.append x[1]
    end
    return xdata, ydata
  end

  def get_date(params, prefix)
    year = params["#{prefix}_date(1i)"]
    mon = params["#{prefix}_date(2i)"]
    mon = '0' + mon if mon.length == 1
    day = params["#{prefix}_date(3i)"]
    day = '0' + day if day.length == 1
    year + '-' + mon + '-' + day
  end
end
