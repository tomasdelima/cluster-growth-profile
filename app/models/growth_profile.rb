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
      devotional_gathering_count: devotional_gathering_count,
      devotional_gathering_participants: devotional_gathering_participants,
      devotional_gathering_non_bahai_friends: devotional_gathering_non_bahai_friends,
      children_classes_count: children_classes_count,
      children_classes_participants: children_classes_participants,
      children_classes_non_bahai_friends: children_classes_non_bahai_friends,
      junior_youth_group_count: junior_youth_group_count,
      junior_youth_group_participants: junior_youth_group_participants,
      junior_youth_group_non_bahai_friends: junior_youth_group_non_bahai_friends,
      study_circle_count: study_circle_count,
      study_circle_participants: study_circle_participants,
      study_circle_non_bahai_friends: study_circle_non_bahai_friends,
    }.to_json
  end
end
