# frozen_string_literal: true

# Holds male/female factors for metabolism calculation
class Factors
  def self.male
    OpenStruct.new(
      {
        base_factor: 66.47,
        weight_factor: 13.7,
        height_factor: 5.0,
        age_factor: 6.8
      }.merge(activity_factors)
    )
  end

  def self.female
    OpenStruct.new(
      {
        base_factor: 655.1,
        weight_factor: 9.6,
        height_factor: 1.8,
        age_factor: 4.7
      }.merge(activity_factors)
    )
  end

  def self.activity_factors
    {
      hours_sleeping: 0.95,
      hours_sitting_low: 1.2,
      hours_sitting_middle: 1.45,
      hours_sitting_high: 1.65,
      hours_standing: 1.85,
      hours_exerting: 2.2
    }
  end
end
