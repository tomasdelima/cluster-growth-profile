class ClusterGrowthController < ApplicationController
  before_action :find_cluster,                     only: [:new, :create]
  before_action :find_growth_profile,              only: [:new, :create]
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
      render file: "public/422.html", status: :unauthorized
    end
  end

  def find_growth_profile
    begin
      cycle = params[:cycle] || current_cycle
      @growth_profile ||= @cluster.growth_profiles.find_by(cycle: cycle) || GrowthProfile.new(cycle: cycle)
    rescue
      render file: "public/422.html", status: :unauthorized
    end
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

  def current_cycle
    today = Date.today

    cycle_number = 1
    cycle_number += 1 if today >= Date.new(today.year, 7, 20)
    cycle_number += 1 if today >= Date.new(today.year, 10, 20)
    cycle_number += 1 if today >= Date.new(today.year + 1, 1, 20)

    year = ((today - Date.new(1844, 4, 20)).days/1.year).ceil

    "#{cycle_number}-#{year}"
  end
end
