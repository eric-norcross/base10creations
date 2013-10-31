FactoryGirl.define do
  factory :brand do |brand|
    brand.title "Some Brand"

    # after(:create) do |brand| 
    #   brand.style create(:brand_style, brand:brand, style: FactoryGirl.build(:style))
    #   brand.reload
    # end
    brand.styles { build_list(:brand_style, 1, {brand: brand, style: build(:style)}) }
  end

  factory :style do |style|
    style.title "Some Style"
  end

  factory :brand_style do
    # brand
    style
  end
end

# FactoryGirl.define do
#   factory :relationship do
#     guardian
#     relationship_type RelationshipType.first

#     after(:build) do |relationship|
#       relationship.student = FactoryGirl.create(:student, school: relationship.guardian.school) unless relationship.student.present?
#     end
#   end
# end


# FactoryGirl.define do
#   factory :brand do
#     title "Pepsi Cola"

#     # after(:create) do |brand|
#     #   Factory(:brand_style, :style => Factory(:style), :brand => brand)
#     #   # email.attachments << FactoryGirl.build(:attachment)
#     # end

#     styles{ |styles| [styles.association :brand]}

#     # factory :brand_with_styles do
#     #   before(:create) {|brand| create_list(:brand_style, brand:brand, style: FactoryGirl.build(:style))}
#     # end
#   end
# end

# FactoryGirl.define do
#   factory :user do
#     after(:custom) {|instance| instance.do_something_custom! }

#     factory :user_with_posts do
#       after(:create) {|instance| create_list(:post, 5, user: instance) }
#     end
#   end
# end


# after(:create) {|brand| Factory(:brand_style, :style => Factory(:style), :brand => brand)}

  # factory :style do
  #   title "Modern"
  # end

  # factory :brand_style do
  #   brand {|a| a.association(:brand)}
  #   style {|a| a.association(:style)}
  # end

# FactoryGirl.define do
#   factory :user do
#     ...
#   end

#   factory :admin, :parent => :user do 
#     after_create {|u| Factory(:assignment, :role => Factory(:role, :name => 'admin', :value => 'admin'), :user => u)}
#   end

#   factory :role do
#     ...
#   end

#   factory :assignment do
#     user {|a| a.association(:user)}
#     role {|a| a.association(:role)}
#   end
# end