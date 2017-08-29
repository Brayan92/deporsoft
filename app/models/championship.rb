class Championship < ApplicationRecord
	has_many :matches
	has_many :championships
  def getMatches
      matches = Match.where(Championship_id:id).count;
      return matches
  end
end
