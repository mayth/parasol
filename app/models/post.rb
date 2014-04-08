# Represents a post for announcement.
#
# @!attribute title
#   @return [String] The post's title.
# @!attribute body
#   @return [String] The post's body.
# @!attribute public_scope
#   @return [String] The scope of publication.
class Post < ActiveRecord::Base
  structure do
    title 'Awesome Post!', validates: :presence
    body "The quick brown fox jumps over the lazy dog.\n" * 20,
         validates: :presence
    public_scope 'player',
                 validation: :presence, inclusion: { in: %w(player public) }
    timestamps
  end

  scope :public_only, -> { where(public_scope: 'public') }
end
