class Role < ActiveHash::Base
  self.data = [
    { id: 1, name: '管理者' },
    { id: 2, name: '看護職' },
    { id: 3, name: '介護職' }
  ]

  include ActiveHash::Associations
  has_many :users
end
