class Interaction < ActiveRecord::Base
  belongs_to :user
end


private

coords_string = "287,507;287,507;298,386;303,335;306,312;308,298;"

def parse_coords(coords)
  parsedCoords=[]
  coords_array = coords.split(";")

  coords_array.each do |pointStr|
    pointArr = pointStr.split(",")
    parsedCoords << {x: pointArr[0].to_i, y: pointArr[1].to_i }
  end
  puts parsedCoords.to_json
end











