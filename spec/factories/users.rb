# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    id { 1 }
    email { 'usama.imran@devsinc.com' }
    password { 'password' }
    role { 'admin' }
    fname { 'Usama' }
    lname { 'Imran' }
    dname { 'Xam' }
  end
end
