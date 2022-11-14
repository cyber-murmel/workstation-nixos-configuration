{
  boot = {
    loader = {
      systemd-boot = {
        # limit the amount of generations kept
        configurationLimit = 3;
      };
    };

    # enable graphical boot, which is cleaner and faster
    plymouth.enable = true;

    kernelParams = [
      # skip unnecessary mode sets during boot
      "i915.fastboot=1"

      # boot with iommu support
      "intel_iommu=on"

      # use cgroups v2
      "systemd.unified_cgroup_hierarchy=1"
    ];
  };
}
