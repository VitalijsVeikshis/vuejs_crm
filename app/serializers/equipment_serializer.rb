class EquipmentSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :title, :kind, :sn
end
