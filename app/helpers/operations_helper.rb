module OperationsHelper

  def create_table_header(header_list)
    raw(header_list.inject("<tr>") { |h, column| h += "<th><strong>#{column}</strong></th>"} + "</tr>")
  end

  def create_data_row(data, methods_list)
    raw(methods_list.inject("") { |r, m| r += "<td>#{data.send(m)}</td>"})
  end
end

