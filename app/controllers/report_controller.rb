class ReportController < ApplicationController
  def consolidated
    set_variables
    set_header
    set_body
    set_totals
    write_cells_to_sheet
    @book.write "tmp/consolidado-#{params[:cycle]}.xlsx"

    send_file "tmp/consolidado-#{params[:cycle]}.xlsx"
  end

  private
    def set_variables
      @book = Spreadsheet::Workbook.new
      @sheet = @book.create_worksheet name: GrowthProfile.to_gregorian_cycle(params[:cycle], :long)[:end_of_cycle][6..-1]
      @current_row = 0
      @current_column = 0
      @cells = []
    end

    def set_header
      ([''] + cluster_attributes.map{|a| I18n.t("activerecord.attributes.cluster.#{a}")} + growth_profile_attributes.map{|a| I18n.t("activerecord.attributes.growth_profile.#{a}")} + ['Total de atividades']).each do |value|
        @cells << {row: @current_row, column: @current_column, value: value, format: border_format(:right)}
        @current_column += 1
      end
      new_row
    end

    def set_body
      growth_profiles.each do |growth_profile|
        @cells << {row: @current_row, column: @current_column, value: @current_row, format: border_format(:right)}
        @current_column += 1

        (cluster_attributes.map {|k| growth_profile.cluster.send(k)} + growth_profile_attributes.map {|k| growth_profile.send(k)}).each do |value|
          @cells << {row: @current_row, column: @current_column, value: value, format: format_by_growth_stage(growth_profile.cluster.growth_stage)}
          @current_column += 1
        end

        value = [:study_circle_count, :devotional_gathering_count, :children_classes_count, :junior_youth_group_count].reduce(0){|m, a| m += growth_profile.send(a) || 0}
        @cells << {row: @current_row, column: @current_column, value: value, format: total_format}
        @cells << {row: @current_row, column: @current_column + 1, value: nil, format: border_format(:left)}

        new_row
      end
    end

    def set_totals
      @cells << {row: @current_row, column: 0, value: nil, format: border_format(:right)}
      ([nil, 'Total', ''] + growth_profile_attributes.map {|k| growth_profiles.reduce(0){|m,  gp| m  += gp.send(k) || 0}} + [[:study_circle_count, :devotional_gathering_count, :children_classes_count, :junior_youth_group_count].reduce(0){|m1, a| m1 += growth_profiles.reduce(0){|m2, gp| m2 += gp.send(a) || 0}}]).each do |value|
        @cells << {row: @current_row, column: @current_column, value: value, format: value ? total_format : nil}
        @current_column += 1
      end
      @cells << {row: @current_row, column: @current_column, value: nil, format: border_format(:left)}
    end

    def write_cells_to_sheet
      @cells.each do |cell|
        write_cell_with_format(cell[:row], cell[:column], cell[:value], cell[:format])
      end
    end

    def write_cell_with_format(row, column, value, format)
      @sheet[row, column] = value
      @sheet.row(row).set_format(column, format) if format
    end

    def growth_profiles
      @growth_profiles ||= GrowthProfile.where(cycle: params[:cycle]).select{|gp| gp.cluster.growth_stage == 'Fronteiras de Aprendizagem'} +
                           GrowthProfile.where(cycle: params[:cycle]).select{|gp| gp.cluster.growth_stage == '3º Marco'} +
                           GrowthProfile.where(cycle: params[:cycle]).select{|gp| gp.cluster.growth_stage == '2º Marco'} +
                           GrowthProfile.where(cycle: params[:cycle]).select{|gp| gp.cluster.growth_stage == '1º Marco'} +
                           GrowthProfile.where(cycle: params[:cycle]).select{|gp| gp.cluster.growth_stage == 'Meta'}
    end

    def cluster_attributes
      [:name, :growth_stage]
    end

    def growth_profile_attributes
      [
        :book1, :book2, :book3grade1, :book3grade2, :book3grade3, :book4, :book5, :book6, :book7, :book8,
        :study_circle_count, :study_circle_participants, :study_circle_non_bahai_friends,
        :devotional_gathering_count, :devotional_gathering_participants, :devotional_gathering_non_bahai_friends,
        :children_classes_count, :children_classes_participants, :children_classes_non_bahai_friends,
        :junior_youth_group_count, :junior_youth_group_participants, :junior_youth_group_non_bahai_friends,
        :expansion_phase_non_bahais_count, :children_and_junior_youth_registered_count,
      ]
    end

    def total_format
      Spreadsheet::Format.new(color: :blue, pattern_fg_color: :yellow, top: :thin, bottom: :thin)
    end

    def border_format(direction)
      Spreadsheet::Format.new(direction => :thin)
    end

    def header_format
      Spreadsheet::Format.new()
    end

    def format_by_growth_stage(growth_stage)
      Spreadsheet::Format.new(pattern_fg_color: colors_by_growth_stage[growth_stage], top: :thin, bottom: :thin, pattern: 1)
    end

    def colors_by_growth_stage
      # More colors at: http://www.softwaremaniacs.net/2013/11/setting-cell-color-using-ruby.html
      color = {
        'Meta'     =>                   :xls_color_18,
        '1º Marco' =>                   :xls_color_35,
        '2º Marco' =>                   :xls_color_26,
        '3º Marco' =>                   :xls_color_43,
        'Fronteiras de Aprendizagem' => :xls_color_44,
      }
    end

    def new_row
      @current_row += 1
      @current_column = 0
    end
end
