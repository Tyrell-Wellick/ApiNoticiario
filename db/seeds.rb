19.times do
  Entry.create({title: Faker::Lorem.characters(rand(6..99)), body: Faker::Lorem.paragraphs(rand(10..100)).join(" "), subtitle: Faker::Lorem.characters(rand(100..199))})
end

19.times do |news_id|
  Entry.find(news_id+1).comments << Comment.new({author: Faker::Name.first_name, comment: Faker::Lorem.characters(rand(200..499))}) << Comment.new({author: Faker::Name.first_name, comment: Faker::Lorem.characters(rand(200..499))}) << Comment.new({author: Faker::Name.first_name, comment: Faker::Lorem.characters(rand(200..499))})
end
