require 'puppet/type/brocade_messages'

Puppet::Type.newtype(:brocade_config_membership) do
  @doc = "This represents a zone config membership on a brocade switch."

  apply_to_device

  ensurable do
    desc "config zone addition, removal ensure property."
    newvalue(:present) do
      provider.create
    end
    newvalue(:absent) do
      provider.destroy
    end
  end

  newparam(:configname) do
    desc "Config name"
    isnamevar
    validate do |value|
      Puppet::Type::Brocade_messages.empty_value_check(value, Puppet::Type::Brocade_messages::CONFIG_NAME_BLANK_ERROR)
      Puppet::Type::Brocade_messages.special_char_check(value, Puppet::Type::Brocade_messages::CONFIG_NAME_SPECIAL_CHAR_ERROR)
    end
  end

  newparam(:member_zone) do
    desc "zone added in the config"
    validate do |value|
      Puppet::Type::Brocade_messages.empty_value_check(value, Puppet::Type::Brocade_messages::ZONE_NAME_BLANK_ERROR)
      Puppet::Type::Brocade_messages.list_special_char_check(value, Puppet::Type::Brocade_messages::ZONE_NAME_SPECIAL_CHAR_ERROR)
    end
  end

end
