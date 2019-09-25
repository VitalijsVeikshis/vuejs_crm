class OrganizationSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :name, :form_of_ownership, :inn, :ogrn
end
