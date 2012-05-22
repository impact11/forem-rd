module Forem
  class Forum
    include Mongoid::Document

    field :title
    field :description
    belongs_to :category, :class_name => 'Forem::Category'
    has_many :topics, :class_name => 'Forem::Topic', :dependent => :destroy
    #has_many :posts, :through => :topics, :dependent => :destroy
    #has_many :views, :through => :topics, :dependent => :destroy

    validates :category_id, :presence => true
    validates :title, :presence => true
    validates :description, :presence => true

    #def posts
    #  # TODO: this is probably a bad idea
    #  self.all.map(&:topics).flatten.map(&:posts).flatten
    #end
    
    def visible_topics(forem_user = nil)
      if forem_user && forem_user.forem_admin?
        topics = self.topics
      else
        topics = self.topics.where(:hidden => false)
      end      
    end

    def posts(forem_user = nil)
      visible_posts(forem_user)      
    end
    
    def views(forem_user = nil)
      visible_views(forem_user)
    end
    
    def visible_posts(forem_user = nil)
      posts = Post.where(:topic_id.in => visible_topics(forem_user).map(&:id))
    end

    def visible_views(forem_user = nil)
      topics = visible_topics(forem_user)
      views = View.where(:topic_id.in => visible_topics(forem_user).map(&:id)).sum(:count)
    end


    def last_post_for(forem_user)
      last_post = visible_posts(forem_user).order_by([['created_at', :desc]]).first
    end

    def last_visible_post
      last_post = visible_posts.order_by([['created_at', :desc]]).first
    end
  end
end
