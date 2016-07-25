class ReportController < ApplicationController
  def consolidated
    row = 1
    rows = []
    cluster_attributes = [:name, :growth_stage]
    growth_profile_attributes = [:book1, :book2, :book3grade1, :book3grade2, :book3grade3, :book4, :book5, :book6, :book7, :book8, :devotional_gathering_count, :devotional_gathering_participants, :devotional_gathering_non_bahai_friends, :children_classes_count, :children_classes_participants, :children_classes_non_bahai_friends, :junior_youth_group_count, :junior_youth_group_participants, :junior_youth_group_non_bahai_friends, :study_circle_count, :study_circle_participants, :study_circle_non_bahai_friends, :expansion_phase_involved_count, :expansion_phase_non_bahais_count, :children_and_junior_youth_registered_count, :new_believers_involved_count, :children_count, :junior_youth_count, :youth_count, :men_count, :women_count, :homes_visited_for_deepening_count, :sites_with_19_days_feasts_count, :participants_of_19_days_feasts_count, :sites_with_holidays_celebrantions_count, :participants_of_holidays_count]
    rows << [0, params[:cycle], 'Nome', 'Estágio de Desenvolvimento'] + growth_profile_attributes.map{|k| I18n.t("activerecord.attributes.growth_profile.#{k}")}

    GrowthProfile.where(cycle: params[:cycle]).each do |growth_profile|
      rows << [row, row] + cluster_attributes.map {|k| growth_profile.cluster.send(k)} + growth_profile_attributes.map {|k| growth_profile.send(k)}
      row += 1
    end

    book = Spreadsheet::Workbook.new
    sheet1 = book.create_worksheet name: 'My Second Worksheet'
    rows.each {|r| sheet1.update_row *r}
    book.write "tmp/consolidado-#{params[:cycle]}.xlsx"
    send_file "tmp/consolidado-#{params[:cycle]}.xlsx"
  end
end
