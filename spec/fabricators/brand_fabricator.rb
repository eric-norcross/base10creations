Fabricator(:brand) do
  title "Coca Cola"

  styles(count: 3) { Fabricate(:style) }

  # before_create do |brand|
  #   STDOUT << "hasdf"
  #   styles Fabricate(:brand_style, :brand => brand, :style => Fabricate(:style))
  # end
end
