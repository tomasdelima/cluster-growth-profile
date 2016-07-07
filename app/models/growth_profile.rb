class GrowthProfile < ActiveRecord::Base
  belongs_to :cluster

  validates :cycle, :cluster_id, presence: true

  serialize :external_human_resources, Array
  serialize :active_internal_human_resources, Array
  serialize :youth_conferences_accompaniments, Array
  serialize :accumulated_pyramid, Hash
  serialize :growth_pyramid, Hash

  attr_accessor :name

  def to_json
    GrowthProfile.fields.reduce({}) do |memo, f|
      memo[f] = send(f)
      memo
    end.to_json
  end

  def name
    "#{cluster.name}: #{cycle}"
  end

  def self.fields
    [
      :cycle,
      :gregorian_cycle,
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
      :external_human_resources,
    # table-10
      :active_internal_human_resources,
    # table-11
      :converted_junior_youth_groups,
      :converted_study_circles,
    # table-12
      :youth_conferences_accompaniments,
    # pyramids
      :accumulated_pyramid,
      :growth_pyramid,
    ]
  end

  def gregorian_cycle
    GrowthProfile.to_gregorian_cycle(cycle)
  end

  def self.to_gregorian_cycle (cycle, format=:short)
    {
      beginning_of_cycle: I18n.l(beginning_of_cycle(cycle), format: format),
      end_of_cycle: I18n.l(end_of_cycle(cycle), format: format)
    }
  end

  def self.beginning_of_cycle (cycle)
    month = cycle[-1].to_i * 3 + 1 - cycle[-1].to_i / 4 * 12
    year = cycle[0..2].to_i + 1843 + (cycle[4] == "4" ? 1 : 0)
    Date.new(year, month, 20)
  end

  def self.end_of_cycle (cycle)
    (beginning_of_cycle(cycle) + 3.months).change(day: 19)
  end
end
