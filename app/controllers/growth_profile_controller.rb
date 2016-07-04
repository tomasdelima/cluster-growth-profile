class GrowthProfileController < ApplicationController
  before_action :find_cluster,                     only: [:new, :create]
  before_action :find_growth_profiles,             only: [:new, :create]
  before_action :assign_growth_profile_attributes, only: [      :create]

  def new
  end

  def create
    growth_profile.cluster = @cluster
    growth_profile.save
    render nothing: true
  end

  private

  def find_cluster
    begin
      @cluster ||= current_user.clusters.find(params[:cluster_id])
    rescue
      render :choose_cluster, status: 422
    end
  end

  def find_growth_profiles
    begin
      @growth_profiles = []
      past_four_cycles.each do |cycle|
        @growth_profiles << @cluster.growth_profiles.find_or_initialize_by(cycle: cycle)
      end
    rescue
      set_cycles_to_choose
      render :choose_cycle, status: 422
    end
  end

  def past_four_cycles
    params[:cycle] ||= params[:growth_profile][:cycle]
    year = params[:cycle][0..4].to_i
    cycle = params[:cycle][4].to_i

    (1..4).map do |count|
      "#{year + (cycle - count)/4}-#{(cycle - count)%4 + 1}"
    end.reverse
  end

  def assign_growth_profile_attributes(gp=growth_profile)
    gp.assign_attributes(growth_profile_params)
    gp.external_human_resources = params[:growth_profile][:external_human_resources]
    gp.active_internal_human_resources = params[:growth_profile][:active_internal_human_resources]
    gp.youth_conferences_accompaniments = params[:growth_profile][:youth_conferences_accompaniments]
    gp.accumulated_pyramid = params[:growth_profile][:accumulated_pyramid]
    gp.growth_pyramid = params[:growth_profile][:growth_pyramid]
  end

  def growth_profile
    @growth_profile ||= GrowthProfile.find_or_initialize_by(cycle: params[:cycle]) do |gp|
      assign_growth_profile_attributes(gp)
    end
  end

  def growth_profile_params
    params[:growth_profile].permit(GrowthProfile.fields)
  end

  def set_cycles_to_choose
    current_year = ((Date.today - Date.new(1844, 4, 20)).days/1.year).ceil
    current_cycle = "#{current_year}-#{(Date.today.month-4)/3%4+1}"
    @cycles_to_choose = (0..3).reduce({}) do |memo1, count|
      year = current_year - count
      memo1[year] = {
        current_year: current_year == year,
        cycles: (1..4).reduce({}) do |memo2, c|
          memo2[c] = {
            active: "#{year}-#{c}" >= current_cycle,
            beginning_of_cycle: GrowthProfile.to_gregorian_cycle("#{year}-#{c}")[:beginning_of_cycle],
            end_of_cycle: GrowthProfile.to_gregorian_cycle("#{year}-#{c}")[:end_of_cycle]
          }
          memo2
        end
      }
      memo1
    end
  end
end
