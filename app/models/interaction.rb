class Interaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :site
end


private

# coords_string = "287,507;287,507;298,386;303,335;306,312;308,298;"

def parse_coords(coords)
  parsedCoords=[]
  coords_array = coords.split(";")

  coords_array.each do |pointStr|
    pointArr = pointStr.split(",")
    parsedCoords << {x: pointArr[0].to_i, y: pointArr[1].to_i }
  end
  return parsedCoords.to_json
end

def combine_coords(coords)
  combined_coords = ""
  coords.each do |coord|
    combined_coords += coord.move
  end
  return parse_coords(combined_coords)
end












