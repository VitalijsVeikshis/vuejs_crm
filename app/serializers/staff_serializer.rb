class StaffSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :email
end
