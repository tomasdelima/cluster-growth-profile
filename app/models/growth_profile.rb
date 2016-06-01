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
    # table-4
      :children_count,
      :junior_youth_count,
      :youth_count,
      :men_count,
      :women_count,
    # table-5
      :homes_visited_for_deepening_count,
      :sites_with_19_days_feasts_count,
      :participants_of_19_days_feasts_count,
      :sites_with_holidays_celebrantions_count,
      :participants_of_holidays_count,
    # table-6
      :devotional_gathering_frequency,
      :children_classes_frequency,
      :junior_youth_group_frequency,
      :study_circle_frequency,
    # table-7
      :concrete_actions,
    # table-8
      :team_people,
      :visits_count,
      :visit_mean_duration,
      :consultation_center,
    # table-9
    # table-10
    ]
  end
end
