require 'rails_admin/config/actions'
require 'rails_admin/config/actions/base'

module RailsAdminDownloadReport
end

module RailsAdmin
  module Config
    module Actions
      class DownloadReport < RailsAdmin::Config::Actions::Base
        register_instance_option :root? do
          true
        end

        register_instance_option :controller do
          Proc.new do
            current_year = ((Date.today - Date.new(1844, 4, 20)).days/1.year).ceil
            current_cycle = "#{current_year}-#{(Date.today.month-4)/3%4+1}"

            @cycles_to_choose = (0..3).reduce({}) do |memo, count|
              year = current_year - count
              (1..4).map do |c|
                memo[GrowthProfile.to_gregorian_cycle("#{year}-#{c}", :long)[:end_of_cycle][6..-1]] = "#{year}-#{c}" if "#{year}-#{c}" <= current_cycle
              end
              memo
            end
          end
        end
      end
    end
  end
end