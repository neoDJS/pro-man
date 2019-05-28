class Project < ApplicationRecord
    has_many :todos
    has_many :workers, through: :todos
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
        self.find_by(id: slugified) || self.find{|p| p.slug == slugified}
    end
end
