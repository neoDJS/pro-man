class Project < ApplicationRecord
    belongs_to :created_by, class_name: "User", foreign_key: "user_id"
    has_many :todos
    has_many :affected_users, through: :todos
    scope :starting, -> { where("created_at < ?", time) }
    scope :ending, -> { where("created_at < ?", time) }
    # scope :created_before, ->(time) { where("created_at < ?", time) }

    def slug
        self.name.gsub(/\W/, '-')
    end

    def self.find_by_slug(slugified)
        self.find{|p| p.slug == slugified}
    end

    def self.find_by_id_or_slug(slugified)
        if slugified.is_a?(Numeric)
            self.find_by(id: slugified)
        else
            self.find{|p| p.slug == slugified}
        end
    end
end
