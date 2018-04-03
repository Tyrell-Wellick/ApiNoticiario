json.array! @news do |new|
  json.id new.id
  json.title new.title
  json.subtitle new.subtitle
  json.body new.body
  json.created_at new.created_at
end
