class GrowthProfile < ActiveRecord::Base
  belongs_to :cluster

  def to_json
    GrowthProfile.fields.reduce({}) do |memo, f|
      memo[f] = send(f)
      memo
    end.to_json
  end

  def self.fields
    [
      :cycle,
    # table-1
      :book1,
      :book2,
      :book3grade1,
      :book3grade2,
      :book3grade3,
      :book4,
      :book5,
      :book6,
      :book7,
      :book8,
    # table-2
      :devotional_gathering_count,
      :devotional_gathering_participants,
      :devotional_gathering_non_bahai_friends,
      :children_classes_count,
      :children_classes_participants,
      :children_classes_non_bahai_friends,
      :junior_youth_group_count,
      :junior_youth_group_participants,
      :junior_youth_group_non_bahai_friends,
      :study_circle_count,
      :study_circle_participants,
      :study_circle_non_bahai_friends,
    # table-3
      :expansion_phase_involved_count,
      :expansion_phase_non_bahais_count,
      :children_and_junior_youth_registered_count,
      :new_believers_involved_count,
    ]
  end
end
