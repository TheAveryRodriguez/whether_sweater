class MapquestSerializer
  include FastJsonapi::ObjectSerializer
  set_id { nil }
  attributes :lat, :lng
end
