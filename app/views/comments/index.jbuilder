json.array! @comments do |comment|
  json.id comment.id
  json.author comment.author
  json.comment comment.comment
  json.created_at comment.created_at
end
