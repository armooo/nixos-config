let
  armooo = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBwaTrkeYzSxckkuV6lEvlvr1wWBiQmL0y7oFT9g+t5O armooo@armframe";
  users = [armooo];

  armframe = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILg75Rm8kwCe07uCvcZx5hUXWipwWz3dQrcC8MowFUYS ";
  systems = [armframe];
in
{
  "initrdEmergencyAccess.age" = {
    publicKeys = systems ++ users;
    armor = true;
  };
}
