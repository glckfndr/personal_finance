require "test_helper"

class CategoryTest < ActiveSupport::TestCase
   test "Return false if name is missing" do
     new_category = Category.new(description: "some description")
     assert_not(new_category.valid?)
   end

   test "Return true if name and description defined" do
     new_category = Category.new(description: "some description", name: "some name")
     assert(new_category.valid?)
   end

   test "Check if category 'Sport' is present in database" do
     category = Category.find_by(name: "Sport")
     assert(category.name == "Sport")
   end

   test "Check if category 'sport' is not present in database" do
     category = Category.find_by(name: "sport")
     assert(category.nil?)
   end

   test "Check if description of category 'Sport' is relevant in database" do
     category = Category.find_by(name: "Sport")
     #puts category.id
     assert(category.description == "pant, shoes, coat")
   end

   test "Check get_all_names" do
     category_names = Set.new Category.get_all_names.pluck(:name)
     assert(category_names == Set.new(["Sport", "Bread", "Meat"]))
   end

end
