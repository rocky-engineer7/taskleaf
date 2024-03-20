class Task < ApplicationRecord
  has_one_attached :image

  validates :name, presence: true, length: {maximum: 30}
  validate :validate_name_not_including_comma

  belongs_to :user

  scope :recent, -> { order(created_at: :desc) }

  def self.ransackable_attributes(auth_objecct = nil)
    %w[name created_at]
  end

  def self.ransackable_associations(auth_objecct = nil)
    []
  end

  def self.csv_attributes
    ["name", "description", "user_id", "created_at", "updated_at"]
  end

  def self.generate_csv(tasks = all)
    CSV.generate(headers: true) do |csv|
      csv << csv_attributes
      tasks.each do |task|
        csv << csv_attributes.map{ |attr| task.send(attr) }
      end
    end
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      task = new
      task.attributes = row.to_hash.slice(*csv_attributes)
      task.user_id = row['user_id']
      unless task.save
        logger.error "Failed to save task: #{task.errors.full_messages.join(', ')}"
      end
    end
  end

  private

  def validate_name_not_including_comma
    errors.add(:name, 'にカンマを含めることはできません') if name&.include?(',')
  end

end
