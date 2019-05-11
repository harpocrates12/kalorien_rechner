# frozen_string_literal: true

require 'ostruct'

# Knows how to calculate caloric requirements based on some params
class CalculateCaloricMetabolism
  def initialize(params)
    @gender = params[:gender]
    @age_in_years = params[:age_in_years]
    @height_in_cm = params[:height_in_cm]
    @weight_in_kilograms = params[:weight_in_kilograms]
    @factors = Factors.send(@gender)
  end

  def call(params)
    basal_metabolism = calculate_basal_metabolism_per_day
    hours_per_activity_level = fetch_hours_per_activity_level(params)

    calculate_caloric_requirement(
      basal_metabolism, hours_per_activity_level
    )
  end

  private

  def calculate_basal_metabolism_per_day
    [
      @factors.base_factor,
      (@factors.weight_factor * @weight_in_kilograms),
      (@factors.height_factor * @height_in_cm),
      -(@factors.age_factor * @age_in_years)
    ].sum
  end

  # rubocop:disable Metrics/MethodLength
  def fetch_hours_per_activity_level(params)
    hours_per_activity_level = {
      hours_sleeping: params[:hours_sleeping],
      hours_sitting_low: params[:hours_sitting_low],
      hours_sitting_middle: params[:hours_sitting_middle],
      hours_sitting_high: params[:hours_sitting_high],
      hours_standing: params[:hours_standing],
      hours_exerting: params[:hours_exerting]
    }

    if hours_per_activity_level.values.sum != 24.0
      raise StandardError 'Provided hours do not match 24!'
    else
      hours_per_activity_level
    end
  end
  # rubocop:enable Metrics/MethodLength

  def calculate_caloric_requirement(basal_metabolism, hours_per_activity_level)
    hours_per_activity_level.map do |key, val|
      val * (basal_metabolism * @factors.send(key))
    end.sum / 24.0
  end
end
