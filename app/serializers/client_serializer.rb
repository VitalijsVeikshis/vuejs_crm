class ClientSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :fullname, :phone, :email
end
