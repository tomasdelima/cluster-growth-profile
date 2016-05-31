class GrowthProfile < ActiveRecord::Base
  belongs_to :cluster

  def to_json
    {
      cycle: cycle,
      book1: book1,
      book2: book2,
      book3grade1: book3grade1,
      book3grade2: book3grade2,
      book3grade3: book3grade3,
      book4: book4,
      book5: book5,
      book6: book6,
      book7: book7,
      book8: book8,
    }.to_json
  end
end
