# vim: set nospell:

template '/etc/udev/rules.d/99-intel-backlight.rules' do
  source 'etc_udev_rulesd_99intelbacklightrules.erb'
  mode 644
end

template '/etc/udev/rules.d/99-dell_kbd_backlight.rules' do
  source 'etc_udev_rulesd_99dellkbdbacklight.erb'
  mode 644
end

execute 'Reload udev rules' do
  command 'udevadm control --reload'
end
