json.array!(@users) do |user|
  json.extract! user, :id, :first_name, :last_name, :nickname, :win_count, :loss_count, :points, :avatar_url
  json.url user_url(user, format: :json)
end
