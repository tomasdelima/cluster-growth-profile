class ClusterGrowthController < ApplicationController
  before_action :find_cluster,                     only: [:new, :create]
  before_action :find_growth_profiles,              only: [:new, :create]
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
  end

  def growth_profile
    @growth_profile ||= GrowthProfile.find_or_initialize_by(cycle: params[:cycle]) do |gp|
      assign_growth_profile_attributes(gp)
    end
  end

  def growth_profile_params
    params[:growth_profile].permit(GrowthProfile.fields)
  end
end
