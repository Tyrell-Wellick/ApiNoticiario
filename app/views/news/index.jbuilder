json.array! @news do |new|
  json.id new.id
  json.title new.title
  json.subtitle new.subtitle
  json.body new.body[0..499]
  json.created_at new.created_at
end
